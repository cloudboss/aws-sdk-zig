const S3AccessPointAttachmentLifecycle = @import("s3_access_point_attachment_lifecycle.zig").S3AccessPointAttachmentLifecycle;
const LifecycleTransitionReason = @import("lifecycle_transition_reason.zig").LifecycleTransitionReason;
const S3AccessPointOntapConfiguration = @import("s3_access_point_ontap_configuration.zig").S3AccessPointOntapConfiguration;
const S3AccessPointOpenZFSConfiguration = @import("s3_access_point_open_zfs_configuration.zig").S3AccessPointOpenZFSConfiguration;
const S3AccessPoint = @import("s3_access_point.zig").S3AccessPoint;
const S3AccessPointAttachmentType = @import("s3_access_point_attachment_type.zig").S3AccessPointAttachmentType;

/// An S3 access point attached to an Amazon FSx volume.
pub const S3AccessPointAttachment = struct {
    creation_time: ?i64,

    /// The lifecycle status of the S3 access point attachment. The lifecycle can
    /// have the following values:
    ///
    /// * AVAILABLE - the S3 access point attachment is available for use
    ///
    /// * CREATING - Amazon FSx is creating the S3 access point and attachment
    ///
    /// * DELETING - Amazon FSx is deleting the S3 access point and attachment
    ///
    /// * FAILED - The S3 access point attachment is in a failed state. Delete and
    ///   detach the S3 access
    /// point attachment, and create a new one.
    ///
    /// * UPDATING - Amazon FSx is updating the S3 access point attachment
    lifecycle: ?S3AccessPointAttachmentLifecycle,

    lifecycle_transition_reason: ?LifecycleTransitionReason,

    /// The name of the S3 access point attachment; also used for the name of the S3
    /// access point.
    name: ?[]const u8,

    /// The ONTAP configuration of the S3 access point attachment.
    ontap_configuration: ?S3AccessPointOntapConfiguration,

    /// The OpenZFSConfiguration of the S3 access point attachment.
    open_zfs_configuration: ?S3AccessPointOpenZFSConfiguration,

    /// The S3 access point configuration of the S3 access point attachment.
    s3_access_point: ?S3AccessPoint,

    /// The type of Amazon FSx volume that the S3 access point is attached to.
    @"type": ?S3AccessPointAttachmentType,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .lifecycle = "Lifecycle",
        .lifecycle_transition_reason = "LifecycleTransitionReason",
        .name = "Name",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .s3_access_point = "S3AccessPoint",
        .@"type" = "Type",
    };
};
