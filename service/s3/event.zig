const std = @import("std");

/// The bucket event for which to send notifications.
pub const Event = enum {
    s_3_reduced_redundancy_lost_object,
    s_3_object_created_,
    s_3_object_created_put,
    s_3_object_created_post,
    s_3_object_created_copy,
    s_3_object_created_complete_multipart_upload,
    s_3_object_removed_,
    s_3_object_removed_delete,
    s_3_object_removed_delete_marker_created,
    s_3_object_restore_,
    s_3_object_restore_post,
    s_3_object_restore_completed,
    s_3_replication_,
    s_3_replication_operation_failed_replication,
    s_3_replication_operation_not_tracked,
    s_3_replication_operation_missed_threshold,
    s_3_replication_operation_replicated_after_threshold,
    s_3_object_restore_delete,
    s_3_lifecycle_transition,
    s_3_intelligent_tiering,
    s_3_object_acl_put,
    s_3_lifecycle_expiration_,
    s_3_lifecycle_expiration_delete,
    s_3_lifecycle_expiration_delete_marker_created,
    s_3_object_tagging_,
    s_3_object_tagging_put,
    s_3_object_tagging_delete,

    pub const json_field_names = .{
        .s_3_reduced_redundancy_lost_object = "s3:ReducedRedundancyLostObject",
        .s_3_object_created_ = "s3:ObjectCreated:*",
        .s_3_object_created_put = "s3:ObjectCreated:Put",
        .s_3_object_created_post = "s3:ObjectCreated:Post",
        .s_3_object_created_copy = "s3:ObjectCreated:Copy",
        .s_3_object_created_complete_multipart_upload = "s3:ObjectCreated:CompleteMultipartUpload",
        .s_3_object_removed_ = "s3:ObjectRemoved:*",
        .s_3_object_removed_delete = "s3:ObjectRemoved:Delete",
        .s_3_object_removed_delete_marker_created = "s3:ObjectRemoved:DeleteMarkerCreated",
        .s_3_object_restore_ = "s3:ObjectRestore:*",
        .s_3_object_restore_post = "s3:ObjectRestore:Post",
        .s_3_object_restore_completed = "s3:ObjectRestore:Completed",
        .s_3_replication_ = "s3:Replication:*",
        .s_3_replication_operation_failed_replication = "s3:Replication:OperationFailedReplication",
        .s_3_replication_operation_not_tracked = "s3:Replication:OperationNotTracked",
        .s_3_replication_operation_missed_threshold = "s3:Replication:OperationMissedThreshold",
        .s_3_replication_operation_replicated_after_threshold = "s3:Replication:OperationReplicatedAfterThreshold",
        .s_3_object_restore_delete = "s3:ObjectRestore:Delete",
        .s_3_lifecycle_transition = "s3:LifecycleTransition",
        .s_3_intelligent_tiering = "s3:IntelligentTiering",
        .s_3_object_acl_put = "s3:ObjectAcl:Put",
        .s_3_lifecycle_expiration_ = "s3:LifecycleExpiration:*",
        .s_3_lifecycle_expiration_delete = "s3:LifecycleExpiration:Delete",
        .s_3_lifecycle_expiration_delete_marker_created = "s3:LifecycleExpiration:DeleteMarkerCreated",
        .s_3_object_tagging_ = "s3:ObjectTagging:*",
        .s_3_object_tagging_put = "s3:ObjectTagging:Put",
        .s_3_object_tagging_delete = "s3:ObjectTagging:Delete",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s_3_reduced_redundancy_lost_object => "s3:ReducedRedundancyLostObject",
            .s_3_object_created_ => "s3:ObjectCreated:*",
            .s_3_object_created_put => "s3:ObjectCreated:Put",
            .s_3_object_created_post => "s3:ObjectCreated:Post",
            .s_3_object_created_copy => "s3:ObjectCreated:Copy",
            .s_3_object_created_complete_multipart_upload => "s3:ObjectCreated:CompleteMultipartUpload",
            .s_3_object_removed_ => "s3:ObjectRemoved:*",
            .s_3_object_removed_delete => "s3:ObjectRemoved:Delete",
            .s_3_object_removed_delete_marker_created => "s3:ObjectRemoved:DeleteMarkerCreated",
            .s_3_object_restore_ => "s3:ObjectRestore:*",
            .s_3_object_restore_post => "s3:ObjectRestore:Post",
            .s_3_object_restore_completed => "s3:ObjectRestore:Completed",
            .s_3_replication_ => "s3:Replication:*",
            .s_3_replication_operation_failed_replication => "s3:Replication:OperationFailedReplication",
            .s_3_replication_operation_not_tracked => "s3:Replication:OperationNotTracked",
            .s_3_replication_operation_missed_threshold => "s3:Replication:OperationMissedThreshold",
            .s_3_replication_operation_replicated_after_threshold => "s3:Replication:OperationReplicatedAfterThreshold",
            .s_3_object_restore_delete => "s3:ObjectRestore:Delete",
            .s_3_lifecycle_transition => "s3:LifecycleTransition",
            .s_3_intelligent_tiering => "s3:IntelligentTiering",
            .s_3_object_acl_put => "s3:ObjectAcl:Put",
            .s_3_lifecycle_expiration_ => "s3:LifecycleExpiration:*",
            .s_3_lifecycle_expiration_delete => "s3:LifecycleExpiration:Delete",
            .s_3_lifecycle_expiration_delete_marker_created => "s3:LifecycleExpiration:DeleteMarkerCreated",
            .s_3_object_tagging_ => "s3:ObjectTagging:*",
            .s_3_object_tagging_put => "s3:ObjectTagging:Put",
            .s_3_object_tagging_delete => "s3:ObjectTagging:Delete",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
