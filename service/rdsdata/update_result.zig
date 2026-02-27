const Field = @import("field.zig").Field;

/// The response elements represent the results of an update.
pub const UpdateResult = struct {
    /// Values for fields generated during the request.
    generated_fields: ?[]const Field,

    pub const json_field_names = .{
        .generated_fields = "generatedFields",
    };
};
