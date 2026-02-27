const CapabilityType = @import("capability_type.zig").CapabilityType;

/// Returns the capability summary details. A trading capability contains the
/// information required to transform incoming EDI documents into JSON or XML
/// outputs.
pub const CapabilitySummary = struct {
    /// Returns a system-assigned unique identifier for the capability.
    capability_id: []const u8,

    /// Returns a timestamp for creation date and time of the capability.
    created_at: i64,

    /// Returns a timestamp that identifies the most recent date and time that the
    /// capability was modified.
    modified_at: ?i64,

    /// The display name of the capability.
    name: []const u8,

    /// Returns the type of the capability. Currently, only `edi` is supported.
    type: CapabilityType,

    pub const json_field_names = .{
        .capability_id = "capabilityId",
        .created_at = "createdAt",
        .modified_at = "modifiedAt",
        .name = "name",
        .type = "type",
    };
};
