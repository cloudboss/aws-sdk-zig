const LegalHoldStatus = @import("legal_hold_status.zig").LegalHoldStatus;

/// A legal hold is an administrative tool that helps prevent backups
/// from being deleted while under a hold. While the hold is in place,
/// backups under a hold cannot be deleted and lifecycle policies that
/// would alter the backup status (such as transition to cold storage) are
/// delayed until the legal hold is removed. A backup can have more than
/// one legal hold. Legal holds are applied to one or more backups
/// (also known as recovery points). These backups can be filtered by resource
/// types and by resource IDs.
pub const LegalHold = struct {
    /// The time when the legal hold was cancelled.
    cancellation_date: ?i64 = null,

    /// The time when the legal hold was created.
    creation_date: ?i64 = null,

    /// The description of a legal hold.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the legal hold; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    legal_hold_arn: ?[]const u8 = null,

    /// The ID of the legal hold.
    legal_hold_id: ?[]const u8 = null,

    /// The status of the legal hold.
    status: ?LegalHoldStatus = null,

    /// The title of a legal hold.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .cancellation_date = "CancellationDate",
        .creation_date = "CreationDate",
        .description = "Description",
        .legal_hold_arn = "LegalHoldArn",
        .legal_hold_id = "LegalHoldId",
        .status = "Status",
        .title = "Title",
    };
};
