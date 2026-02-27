const Readiness = @import("readiness.zig").Readiness;

/// The data store response.
pub const DataStoreResponse = struct {
    /// True if data store is enabled for this domain
    enabled: ?bool,

    readiness: ?Readiness,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .readiness = "Readiness",
    };
};
