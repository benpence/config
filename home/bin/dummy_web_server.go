// Dummy Web Server listens on the user-supplied IPv4 or IPv6 sockets for http
// connections and responds with a 200 OK http code and no body. Its intended
// to be used in conjunction with a local DNS service such as /etc/hosts
// or private bind server so you can gracefully block specific domains for
// tracking-avoidance or bandwidth reduction purposes.
//
// Dummy Web Server also logs to stdout each connection:
// YEAR-MONTH-DAY HOUR:MIN:SEC REMOTE_IP -> URL_HOST URL_PATH HTTP_METHOD HTTP_REFERER
package main

import (
    "os"
    "time"
    "fmt"
    "net/http"
)

const TimeFormat = "2006-01-02 15:04:05"
func handle(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(200)
    fmt.Printf(
        "%v %v -> %v %v %v %v\n",
        time.Now().Format(TimeFormat),
        r.RemoteAddr,
        r.Host,
        r.URL,
        r.Method,
        r.Referer())
}

func listen(addressString string, quitCh chan bool) {
    if err := http.ListenAndServe(addressString, nil); err != nil {
        fmt.Println(err)
        quitCh <- true
    }
}

func main() {
    if len(os.Args) == 1 {
        fmt.Printf("Usage: %s IPv4:PORT [IPv6]:PORT ...", os.Args[0])
        return
    }

    http.HandleFunc("/", handle)

    done := make(chan bool)
    for _, s := range os.Args[1:] {
        go listen(s, done)
    }

    <- done
}
