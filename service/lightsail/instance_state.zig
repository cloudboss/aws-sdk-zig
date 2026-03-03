/// Describes the virtual private server (or *instance*) status.
pub const InstanceState = struct {
    /// The status code for the instance.
    code: ?i32 = null,

    /// The state of the instance (`running` or `pending`).
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .name = "name",
    };
};
