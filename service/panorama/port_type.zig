pub const PortType = enum {
    boolean,
    string,
    int32,
    float32,
    media,

    pub const json_field_names = .{
        .boolean = "BOOLEAN",
        .string = "STRING",
        .int32 = "INT32",
        .float32 = "FLOAT32",
        .media = "MEDIA",
    };
};
