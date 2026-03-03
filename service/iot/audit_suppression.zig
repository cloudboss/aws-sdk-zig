const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;

/// Filters out specific findings of a Device Defender audit.
pub const AuditSuppression = struct {
    check_name: []const u8,

    /// The description of the audit suppression.
    description: ?[]const u8 = null,

    /// The expiration date (epoch timestamp in seconds) that you want the
    /// suppression to adhere to.
    expiration_date: ?i64 = null,

    resource_identifier: ResourceIdentifier,

    /// Indicates whether a suppression should exist indefinitely or not.
    suppress_indefinitely: ?bool = null,

    pub const json_field_names = .{
        .check_name = "checkName",
        .description = "description",
        .expiration_date = "expirationDate",
        .resource_identifier = "resourceIdentifier",
        .suppress_indefinitely = "suppressIndefinitely",
    };
};
