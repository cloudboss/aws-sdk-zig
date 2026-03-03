const aws = @import("aws");

const IPSetReference = @import("ip_set_reference.zig").IPSetReference;

/// Contains a set of IP set references.
pub const ReferenceSets = struct {
    /// The list of IP set references.
    ip_set_references: ?[]const aws.map.MapEntry(IPSetReference) = null,

    pub const json_field_names = .{
        .ip_set_references = "IPSetReferences",
    };
};
