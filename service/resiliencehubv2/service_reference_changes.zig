const ServiceReference = @import("service_reference.zig").ServiceReference;

/// Describes changes to service references.
pub const ServiceReferenceChanges = struct {
    /// The list of service references that were added.
    added: ?[]const ServiceReference = null,

    /// The list of service references that were removed.
    removed: ?[]const ServiceReference = null,

    pub const json_field_names = .{
        .added = "added",
        .removed = "removed",
    };
};
