const TemplateErrorType = @import("template_error_type.zig").TemplateErrorType;
const Entity = @import("entity.zig").Entity;

/// List of errors that occurred when the template version creation failed.
pub const TemplateError = struct {
    /// Description of the error type.
    message: ?[]const u8,

    /// Type of error.
    type: ?TemplateErrorType,

    /// An error path that shows which entities caused the template error.
    violated_entities: ?[]const Entity,

    pub const json_field_names = .{
        .message = "Message",
        .type = "Type",
        .violated_entities = "ViolatedEntities",
    };
};
