const SignedObject = @import("signed_object.zig").SignedObject;
const SigningMaterial = @import("signing_material.zig").SigningMaterial;
const Source = @import("source.zig").Source;
const SigningStatus = @import("signing_status.zig").SigningStatus;

/// Contains information about a signing job.
pub const SigningJob = struct {
    /// The date and time that the signing job was created.
    created_at: ?i64,

    /// Indicates whether the signing job is revoked.
    is_revoked: bool = false,

    /// The ID of the signing job.
    job_id: ?[]const u8,

    /// The AWS account ID of the job invoker.
    job_invoker: ?[]const u8,

    /// The AWS account ID of the job owner.
    job_owner: ?[]const u8,

    /// The name of a signing platform.
    platform_display_name: ?[]const u8,

    /// The unique identifier for a signing platform.
    platform_id: ?[]const u8,

    /// The name of the signing profile that created a signing job.
    profile_name: ?[]const u8,

    /// The version of the signing profile that created a signing job.
    profile_version: ?[]const u8,

    /// The time when the signature of a signing job expires.
    signature_expires_at: ?i64,

    /// A `SignedObject` structure that contains information about a signing job's
    /// signed code image.
    signed_object: ?SignedObject,

    /// A `SigningMaterial` object that contains the Amazon Resource Name (ARN) of
    /// the certificate used for the signing job.
    signing_material: ?SigningMaterial,

    /// A `Source` that contains information about a signing job's code image
    /// source.
    source: ?Source,

    /// The status of the signing job.
    status: ?SigningStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .is_revoked = "isRevoked",
        .job_id = "jobId",
        .job_invoker = "jobInvoker",
        .job_owner = "jobOwner",
        .platform_display_name = "platformDisplayName",
        .platform_id = "platformId",
        .profile_name = "profileName",
        .profile_version = "profileVersion",
        .signature_expires_at = "signatureExpiresAt",
        .signed_object = "signedObject",
        .signing_material = "signingMaterial",
        .source = "source",
        .status = "status",
    };
};
