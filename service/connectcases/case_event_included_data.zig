const FieldIdentifier = @import("field_identifier.zig").FieldIdentifier;

/// Details of what case data is published through the case event stream.
pub const CaseEventIncludedData = struct {
    /// List of field identifiers.
    fields: []const FieldIdentifier,

    pub const json_field_names = .{
        .fields = "fields",
    };
};
