const TargetIdentifier = @import("target_identifier.zig").TargetIdentifier;

/// A target resource in a scope. The resource is identified by a Region and an
/// account, defined by a target identifier. A target identifier is made up of a
/// target ID (currently always an account ID) and a target type (currently
/// always `ACCOUNT`).
pub const TargetResource = struct {
    /// The Amazon Web Services Region for the scope.
    region: []const u8,

    /// A target identifier is a pair of identifying information for a scope. A
    /// target identifier is made up of a targetID (currently always an account ID)
    /// and a targetType (currently always an account).
    target_identifier: TargetIdentifier,

    pub const json_field_names = .{
        .region = "region",
        .target_identifier = "targetIdentifier",
    };
};
