const Format = @import("format.zig").Format;
const Schema = @import("schema.zig").Schema;

/// Contains information about an audit log processing configuration.
pub const AuditLogProcessingConfiguration = struct {
    /// The format in which the audit logs need to be formatted.
    format: Format,

    /// The event schema in which the audit logs need to be formatted.
    schema: Schema,

    pub const json_field_names = .{
        .format = "format",
        .schema = "schema",
    };
};
