const aws = @import("aws");

const FieldValue = @import("field_value.zig").FieldValue;

/// A list of items that represent cases.
pub const SearchCasesResponseItem = struct {
    /// A unique identifier of the case.
    case_id: []const u8,

    /// List of case field values.
    fields: []const FieldValue,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
        .fields = "fields",
        .tags = "tags",
        .template_id = "templateId",
    };
};
