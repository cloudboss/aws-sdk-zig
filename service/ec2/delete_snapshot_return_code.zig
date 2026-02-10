const SnapshotReturnCodes = @import("snapshot_return_codes.zig").SnapshotReturnCodes;

/// The snapshot ID and its deletion result code.
pub const DeleteSnapshotReturnCode = struct {
    /// The result code from the snapshot deletion attempt. Possible values:
    ///
    /// * `success` - The snapshot was successfully deleted.
    ///
    /// * `skipped` - The snapshot was not deleted because it's associated with
    ///   other
    /// AMIs.
    ///
    /// * `missing-permissions` - The snapshot was not deleted because the role
    ///   lacks
    /// `DeleteSnapshot` permissions. For more information, see [How
    /// Amazon EBS works with
    /// IAM](https://docs.aws.amazon.com/ebs/latest/userguide/security_iam_service-with-iam.html).
    ///
    /// * `internal-error` - The snapshot was not deleted due to a server
    /// error.
    ///
    /// * `client-error` - The snapshot was not deleted due to a client
    ///   configuration
    /// error.
    ///
    /// For details about an error, check the `DeleteSnapshot` event in the
    /// CloudTrail
    /// event history. For more information, see [View event
    /// history](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/tutorial-event-history.html)
    /// in the *Amazon Web Services CloudTrail User Guide*.
    return_code: ?SnapshotReturnCodes,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,
};
