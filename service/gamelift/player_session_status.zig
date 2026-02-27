pub const PlayerSessionStatus = enum {
    reserved,
    active,
    completed,
    timedout,

    pub const json_field_names = .{
        .reserved = "RESERVED",
        .active = "ACTIVE",
        .completed = "COMPLETED",
        .timedout = "TIMEDOUT",
    };
};
