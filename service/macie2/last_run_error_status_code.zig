/// Specifies whether any account- or bucket-level access errors occurred during
/// the run of a one-time classification job or the most recent run of a
/// recurring classification job. Possible values are:
pub const LastRunErrorStatusCode = enum {
    none,
    @"error",

    pub const json_field_names = .{
        .none = "NONE",
        .@"error" = "ERROR",
    };
};
