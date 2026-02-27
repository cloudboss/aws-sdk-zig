const ServiceType = @import("service_type.zig").ServiceType;

/// The authorized targets that are associated with a service.
pub const AuthorizedTargetsByService = struct {
    /// Aist of authorized targets that are represented by IAM Identity Center
    /// application ARNs.
    authorized_targets: ?[]const []const u8,

    /// The name of the Amazon Web Services service.
    service: ?ServiceType,

    pub const json_field_names = .{
        .authorized_targets = "AuthorizedTargets",
        .service = "Service",
    };
};
