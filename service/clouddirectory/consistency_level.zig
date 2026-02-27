pub const ConsistencyLevel = enum {
    serializable,
    eventual,

    pub const json_field_names = .{
        .serializable = "SERIALIZABLE",
        .eventual = "EVENTUAL",
    };
};
