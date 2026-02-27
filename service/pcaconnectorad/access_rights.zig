const AccessRight = @import("access_right.zig").AccessRight;

/// Allow or deny permissions for an Active Directory group to enroll or
/// autoenroll certificates for a
/// template.
pub const AccessRights = struct {
    /// Allow or deny an Active Directory group from autoenrolling certificates
    /// issued against a template.
    /// The Active Directory group must be allowed to enroll to allow autoenrollment
    auto_enroll: ?AccessRight,

    /// Allow or deny an Active Directory group from enrolling certificates issued
    /// against a
    /// template.
    enroll: ?AccessRight,

    pub const json_field_names = .{
        .auto_enroll = "AutoEnroll",
        .enroll = "Enroll",
    };
};
