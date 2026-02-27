const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;

/// Filters out specific findings of a Device Defender audit.
pub const AuditSuppression = struct {
    check_name: []const u8,

    /// The description of the audit suppression.
    description: ?[]const u8,

    /// The expiration date (epoch timestamp in seconds) that you want the
    /// suppression to adhere to.
    expiration_date: ?i64,

    resource_identifier: ResourceIdentifier,

    /// Indicates whether a suppression should exist indefinitely or not.
    suppress_indefinitely: ?bool,

    pub const json_field_names = .{
        .check_name = "checkName",
        .description = "description",
        .expiration_date = "expirationDate",
        .resource_identifier = "resourceIdentifier",
        .suppress_indefinitely = "suppressIndefinitely",
    };
};
