/// The information about the specified parameter in the request that caused an
/// error.
pub const ValidationExceptionField = struct {
    /// The name of the parameter that caused a `ValidationException` error.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
