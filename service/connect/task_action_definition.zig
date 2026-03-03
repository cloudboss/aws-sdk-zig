const aws = @import("aws");

const Reference = @import("reference.zig").Reference;

/// Information about the task action.
pub const TaskActionDefinition = struct {
    /// The identifier of the flow.
    contact_flow_id: []const u8,

    /// The description. Supports variable injection. For more information, see
    /// [JSONPath
    /// reference](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-variable-injection.html)
    /// in the *Amazon Connect Administrators Guide*.
    description: ?[]const u8 = null,

    /// The name. Supports variable injection. For more information, see
    /// [JSONPath
    /// reference](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-variable-injection.html)
    /// in the *Amazon Connect Administrators Guide*.
    name: []const u8,

    /// Information about the reference when the `referenceType` is `URL`.
    /// Otherwise, null.
    /// (Supports variable injection in the `Value` field.)
    references: ?[]const aws.map.MapEntry(Reference) = null,

    pub const json_field_names = .{
        .contact_flow_id = "ContactFlowId",
        .description = "Description",
        .name = "Name",
        .references = "References",
    };
};
