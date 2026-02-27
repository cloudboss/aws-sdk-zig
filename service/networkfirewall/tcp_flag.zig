pub const TCPFlag = enum {
    fin,
    syn,
    rst,
    psh,
    ack,
    urg,
    ece,
    cwr,

    pub const json_field_names = .{
        .fin = "FIN",
        .syn = "SYN",
        .rst = "RST",
        .psh = "PSH",
        .ack = "ACK",
        .urg = "URG",
        .ece = "ECE",
        .cwr = "CWR",
    };
};
