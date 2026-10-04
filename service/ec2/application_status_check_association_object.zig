const AssociationTypeEnum = @import("association_type_enum.zig").AssociationTypeEnum;

/// Information about an application status check association. Each item in the
/// `associationSet` of a `DescribeApplicationStatusCheckAssociations` response
/// is of this type.
pub const ApplicationStatusCheckAssociationObject = struct {
    /// The ID of the application status check.
    application_status_check_id: ?[]const u8 = null,

    /// The type of target that the application status check is associated with.
    /// Possible values:
    ///
    /// * `tag` – The check applies to current and future instances with a matching
    ///   tag key-value pair.
    ///
    /// * `instance-id` – The check applies to a specific instance.
    association_type: ?AssociationTypeEnum = null,

    /// The key for the association. This value is present only for tag-based
    /// associations, where it contains the tag key. For instance-based
    /// associations, this value is absent.
    key: ?[]const u8 = null,

    /// The value for the association target. For tag-based associations, this is
    /// the tag value. For instance-based associations, this is the instance ID (for
    /// example, `i-0123456789abcdef0`).
    value: ?[]const u8 = null,
};
