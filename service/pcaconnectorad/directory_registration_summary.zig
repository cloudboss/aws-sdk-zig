const DirectoryRegistrationStatus = @import("directory_registration_status.zig").DirectoryRegistrationStatus;
const DirectoryRegistrationStatusReason = @import("directory_registration_status_reason.zig").DirectoryRegistrationStatusReason;

/// The directory registration represents the authorization of the connector
/// service with
/// the Active Directory.
pub const DirectoryRegistrationSummary = struct {
    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateDirectoryRegistration](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateDirectoryRegistration.html).
    arn: ?[]const u8,

    /// The date and time that the directory registration was created.
    created_at: ?i64,

    /// The identifier of the Active Directory.
    directory_id: ?[]const u8,

    /// Status of the directory registration.
    status: ?DirectoryRegistrationStatus,

    /// Additional information about the directory registration status if the status
    /// is
    /// failed.
    status_reason: ?DirectoryRegistrationStatusReason,

    /// The date and time that the directory registration was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .directory_id = "DirectoryId",
        .status = "Status",
        .status_reason = "StatusReason",
        .updated_at = "UpdatedAt",
    };
};
