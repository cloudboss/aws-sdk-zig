const aws = @import("aws");
const std = @import("std");

const AbacStatus = @import("abac_status.zig").AbacStatus;
const AbortIncompleteMultipartUpload = @import("abort_incomplete_multipart_upload.zig").AbortIncompleteMultipartUpload;
const AccessControlTranslation = @import("access_control_translation.zig").AccessControlTranslation;
const AnalyticsConfiguration = @import("analytics_configuration.zig").AnalyticsConfiguration;
const AnalyticsExportDestination = @import("analytics_export_destination.zig").AnalyticsExportDestination;
const AnalyticsS3BucketDestination = @import("analytics_s_3_bucket_destination.zig").AnalyticsS3BucketDestination;
const AnalyticsS3ExportFileFormat = @import("analytics_s_3_export_file_format.zig").AnalyticsS3ExportFileFormat;
const BlockedEncryptionTypes = @import("blocked_encryption_types.zig").BlockedEncryptionTypes;
const Bucket = @import("bucket.zig").Bucket;
const BucketAbacStatus = @import("bucket_abac_status.zig").BucketAbacStatus;
const BucketLogsPermission = @import("bucket_logs_permission.zig").BucketLogsPermission;
const CORSRule = @import("cors_rule.zig").CORSRule;
const Checksum = @import("checksum.zig").Checksum;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const CommonPrefix = @import("common_prefix.zig").CommonPrefix;
const Condition = @import("condition.zig").Condition;
const CopyObjectResult = @import("copy_object_result.zig").CopyObjectResult;
const CopyPartResult = @import("copy_part_result.zig").CopyPartResult;
const DefaultRetention = @import("default_retention.zig").DefaultRetention;
const DeleteMarkerEntry = @import("delete_marker_entry.zig").DeleteMarkerEntry;
const DeleteMarkerReplication = @import("delete_marker_replication.zig").DeleteMarkerReplication;
const DeleteMarkerReplicationStatus = @import("delete_marker_replication_status.zig").DeleteMarkerReplicationStatus;
const DeletedObject = @import("deleted_object.zig").DeletedObject;
const Destination = @import("destination.zig").Destination;
const DestinationResult = @import("destination_result.zig").DestinationResult;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const EncryptionType = @import("encryption_type.zig").EncryptionType;
const Error = @import("error.zig").Error;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const ErrorDocument = @import("error_document.zig").ErrorDocument;
const Event = @import("event.zig").Event;
const EventBridgeConfiguration = @import("event_bridge_configuration.zig").EventBridgeConfiguration;
const ExistingObjectReplication = @import("existing_object_replication.zig").ExistingObjectReplication;
const ExistingObjectReplicationStatus = @import("existing_object_replication_status.zig").ExistingObjectReplicationStatus;
const ExpirationState = @import("expiration_state.zig").ExpirationState;
const ExpirationStatus = @import("expiration_status.zig").ExpirationStatus;
const FilterRule = @import("filter_rule.zig").FilterRule;
const FilterRuleName = @import("filter_rule_name.zig").FilterRuleName;
const GetBucketMetadataConfigurationResult = @import("get_bucket_metadata_configuration_result.zig").GetBucketMetadataConfigurationResult;
const GetBucketMetadataTableConfigurationResult = @import("get_bucket_metadata_table_configuration_result.zig").GetBucketMetadataTableConfigurationResult;
const GetObjectAttributesParts = @import("get_object_attributes_parts.zig").GetObjectAttributesParts;
const Grant = @import("grant.zig").Grant;
const Grantee = @import("grantee.zig").Grantee;
const IndexDocument = @import("index_document.zig").IndexDocument;
const Initiator = @import("initiator.zig").Initiator;
const IntelligentTieringAccessTier = @import("intelligent_tiering_access_tier.zig").IntelligentTieringAccessTier;
const IntelligentTieringAndOperator = @import("intelligent_tiering_and_operator.zig").IntelligentTieringAndOperator;
const IntelligentTieringConfiguration = @import("intelligent_tiering_configuration.zig").IntelligentTieringConfiguration;
const IntelligentTieringFilter = @import("intelligent_tiering_filter.zig").IntelligentTieringFilter;
const IntelligentTieringStatus = @import("intelligent_tiering_status.zig").IntelligentTieringStatus;
const InventoryConfiguration = @import("inventory_configuration.zig").InventoryConfiguration;
const InventoryConfigurationState = @import("inventory_configuration_state.zig").InventoryConfigurationState;
const InventoryDestination = @import("inventory_destination.zig").InventoryDestination;
const InventoryEncryption = @import("inventory_encryption.zig").InventoryEncryption;
const InventoryFilter = @import("inventory_filter.zig").InventoryFilter;
const InventoryFormat = @import("inventory_format.zig").InventoryFormat;
const InventoryFrequency = @import("inventory_frequency.zig").InventoryFrequency;
const InventoryIncludedObjectVersions = @import("inventory_included_object_versions.zig").InventoryIncludedObjectVersions;
const InventoryOptionalField = @import("inventory_optional_field.zig").InventoryOptionalField;
const InventoryS3BucketDestination = @import("inventory_s_3_bucket_destination.zig").InventoryS3BucketDestination;
const InventorySchedule = @import("inventory_schedule.zig").InventorySchedule;
const InventoryTableConfigurationResult = @import("inventory_table_configuration_result.zig").InventoryTableConfigurationResult;
const JournalTableConfigurationResult = @import("journal_table_configuration_result.zig").JournalTableConfigurationResult;
const LambdaFunctionConfiguration = @import("lambda_function_configuration.zig").LambdaFunctionConfiguration;
const LifecycleExpiration = @import("lifecycle_expiration.zig").LifecycleExpiration;
const LifecycleRule = @import("lifecycle_rule.zig").LifecycleRule;
const LifecycleRuleAndOperator = @import("lifecycle_rule_and_operator.zig").LifecycleRuleAndOperator;
const LifecycleRuleFilter = @import("lifecycle_rule_filter.zig").LifecycleRuleFilter;
const LoggingEnabled = @import("logging_enabled.zig").LoggingEnabled;
const MetadataConfigurationResult = @import("metadata_configuration_result.zig").MetadataConfigurationResult;
const MetadataTableConfigurationResult = @import("metadata_table_configuration_result.zig").MetadataTableConfigurationResult;
const Metrics = @import("metrics.zig").Metrics;
const MetricsConfiguration = @import("metrics_configuration.zig").MetricsConfiguration;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const MultipartUpload = @import("multipart_upload.zig").MultipartUpload;
const NoncurrentVersionExpiration = @import("noncurrent_version_expiration.zig").NoncurrentVersionExpiration;
const NoncurrentVersionTransition = @import("noncurrent_version_transition.zig").NoncurrentVersionTransition;
const NotificationConfigurationFilter = @import("notification_configuration_filter.zig").NotificationConfigurationFilter;
const Object = @import("object.zig").Object;
const ObjectLockConfiguration = @import("object_lock_configuration.zig").ObjectLockConfiguration;
const ObjectLockEnabled = @import("object_lock_enabled.zig").ObjectLockEnabled;
const ObjectLockLegalHold = @import("object_lock_legal_hold.zig").ObjectLockLegalHold;
const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;
const ObjectLockRetention = @import("object_lock_retention.zig").ObjectLockRetention;
const ObjectLockRetentionMode = @import("object_lock_retention_mode.zig").ObjectLockRetentionMode;
const ObjectLockRule = @import("object_lock_rule.zig").ObjectLockRule;
const ObjectOwnership = @import("object_ownership.zig").ObjectOwnership;
const ObjectPart = @import("object_part.zig").ObjectPart;
const ObjectStorageClass = @import("object_storage_class.zig").ObjectStorageClass;
const ObjectVersion = @import("object_version.zig").ObjectVersion;
const ObjectVersionStorageClass = @import("object_version_storage_class.zig").ObjectVersionStorageClass;
const Owner = @import("owner.zig").Owner;
const OwnerOverride = @import("owner_override.zig").OwnerOverride;
const OwnershipControls = @import("ownership_controls.zig").OwnershipControls;
const OwnershipControlsRule = @import("ownership_controls_rule.zig").OwnershipControlsRule;
const Part = @import("part.zig").Part;
const PartitionDateSource = @import("partition_date_source.zig").PartitionDateSource;
const PartitionedPrefix = @import("partitioned_prefix.zig").PartitionedPrefix;
const Permission = @import("permission.zig").Permission;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;
const Protocol = @import("protocol.zig").Protocol;
const PublicAccessBlockConfiguration = @import("public_access_block_configuration.zig").PublicAccessBlockConfiguration;
const QueueConfiguration = @import("queue_configuration.zig").QueueConfiguration;
const RecordExpiration = @import("record_expiration.zig").RecordExpiration;
const Redirect = @import("redirect.zig").Redirect;
const RedirectAllRequestsTo = @import("redirect_all_requests_to.zig").RedirectAllRequestsTo;
const ReplicaModifications = @import("replica_modifications.zig").ReplicaModifications;
const ReplicaModificationsStatus = @import("replica_modifications_status.zig").ReplicaModificationsStatus;
const ReplicationConfiguration = @import("replication_configuration.zig").ReplicationConfiguration;
const ReplicationRule = @import("replication_rule.zig").ReplicationRule;
const ReplicationRuleAndOperator = @import("replication_rule_and_operator.zig").ReplicationRuleAndOperator;
const ReplicationRuleFilter = @import("replication_rule_filter.zig").ReplicationRuleFilter;
const ReplicationRuleStatus = @import("replication_rule_status.zig").ReplicationRuleStatus;
const ReplicationTime = @import("replication_time.zig").ReplicationTime;
const ReplicationTimeStatus = @import("replication_time_status.zig").ReplicationTimeStatus;
const ReplicationTimeValue = @import("replication_time_value.zig").ReplicationTimeValue;
const RestoreStatus = @import("restore_status.zig").RestoreStatus;
const RoutingRule = @import("routing_rule.zig").RoutingRule;
const S3KeyFilter = @import("s_3_key_filter.zig").S3KeyFilter;
const S3TablesBucketType = @import("s_3_tables_bucket_type.zig").S3TablesBucketType;
const S3TablesDestinationResult = @import("s_3_tables_destination_result.zig").S3TablesDestinationResult;
const SSEKMS = @import("ssekms.zig").SSEKMS;
const SSES3 = @import("sses3.zig").SSES3;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const ServerSideEncryptionByDefault = @import("server_side_encryption_by_default.zig").ServerSideEncryptionByDefault;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const ServerSideEncryptionRule = @import("server_side_encryption_rule.zig").ServerSideEncryptionRule;
const SessionCredentials = @import("session_credentials.zig").SessionCredentials;
const SimplePrefix = @import("simple_prefix.zig").SimplePrefix;
const SourceSelectionCriteria = @import("source_selection_criteria.zig").SourceSelectionCriteria;
const SseKmsEncryptedObjects = @import("sse_kms_encrypted_objects.zig").SseKmsEncryptedObjects;
const SseKmsEncryptedObjectsStatus = @import("sse_kms_encrypted_objects_status.zig").SseKmsEncryptedObjectsStatus;
const StorageClass = @import("storage_class.zig").StorageClass;
const StorageClassAnalysis = @import("storage_class_analysis.zig").StorageClassAnalysis;
const StorageClassAnalysisDataExport = @import("storage_class_analysis_data_export.zig").StorageClassAnalysisDataExport;
const StorageClassAnalysisSchemaVersion = @import("storage_class_analysis_schema_version.zig").StorageClassAnalysisSchemaVersion;
const Tag = @import("tag.zig").Tag;
const TargetGrant = @import("target_grant.zig").TargetGrant;
const TargetObjectKeyFormat = @import("target_object_key_format.zig").TargetObjectKeyFormat;
const Tiering = @import("tiering.zig").Tiering;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;
const Transition = @import("transition.zig").Transition;
const TransitionStorageClass = @import("transition_storage_class.zig").TransitionStorageClass;
const Type = @import("type.zig").Type;

pub fn deserializeAllowedHeaders(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAllowedMethods(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAllowedOrigins(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAnalyticsConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AnalyticsConfiguration {
    var list: std.ArrayList(AnalyticsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAnalyticsConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeBuckets(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Bucket {
    var list: std.ArrayList(Bucket) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeBucket(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCORSRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CORSRule {
    var list: std.ArrayList(CORSRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCORSRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeChecksumAlgorithmList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ChecksumAlgorithm {
    var list: std.ArrayList(ChecksumAlgorithm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(ChecksumAlgorithm, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCommonPrefixList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CommonPrefix {
    var list: std.ArrayList(CommonPrefix) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCommonPrefix(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDeleteMarkers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DeleteMarkerEntry {
    var list: std.ArrayList(DeleteMarkerEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDeleteMarkerEntry(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDeletedObjects(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DeletedObject {
    var list: std.ArrayList(DeletedObject) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDeletedObject(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEncryptionTypeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EncryptionType {
    var list: std.ArrayList(EncryptionType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(EncryptionType, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeErrors(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Error {
    var list: std.ArrayList(Error) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeError(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEventList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Event {
    var list: std.ArrayList(Event) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(Event, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeExposeHeaders(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFilterRuleList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const FilterRule {
    var list: std.ArrayList(FilterRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeFilterRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeGrants(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Grant {
    var list: std.ArrayList(Grant) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGrant(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeIntelligentTieringConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const IntelligentTieringConfiguration {
    var list: std.ArrayList(IntelligentTieringConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeIntelligentTieringConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInventoryConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InventoryConfiguration {
    var list: std.ArrayList(InventoryConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInventoryConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInventoryOptionalFields(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InventoryOptionalField {
    var list: std.ArrayList(InventoryOptionalField) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(InventoryOptionalField, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeLambdaFunctionConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LambdaFunctionConfiguration {
    var list: std.ArrayList(LambdaFunctionConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLambdaFunctionConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeLifecycleRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LifecycleRule {
    var list: std.ArrayList(LifecycleRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLifecycleRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricsConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricsConfiguration {
    var list: std.ArrayList(MetricsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricsConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMultipartUploadList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MultipartUpload {
    var list: std.ArrayList(MultipartUpload) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMultipartUpload(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeNoncurrentVersionTransitionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NoncurrentVersionTransition {
    var list: std.ArrayList(NoncurrentVersionTransition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeNoncurrentVersionTransition(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeObjectList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Object {
    var list: std.ArrayList(Object) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeObject(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeObjectVersionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ObjectVersion {
    var list: std.ArrayList(ObjectVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeObjectVersion(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOwnershipControlsRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OwnershipControlsRule {
    var list: std.ArrayList(OwnershipControlsRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOwnershipControlsRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeParts(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Part {
    var list: std.ArrayList(Part) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePart(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePartsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ObjectPart {
    var list: std.ArrayList(ObjectPart) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeObjectPart(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeQueueConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const QueueConfiguration {
    var list: std.ArrayList(QueueConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeQueueConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReplicationRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReplicationRule {
    var list: std.ArrayList(ReplicationRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReplicationRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRoutingRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RoutingRule {
    var list: std.ArrayList(RoutingRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRoutingRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeServerSideEncryptionRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ServerSideEncryptionRule {
    var list: std.ArrayList(ServerSideEncryptionRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeServerSideEncryptionRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTagSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTag(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTargetGrants(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TargetGrant {
    var list: std.ArrayList(TargetGrant) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTargetGrant(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTieringList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tiering {
    var list: std.ArrayList(Tiering) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTiering(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTopicConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TopicConfiguration {
    var list: std.ArrayList(TopicConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTopicConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTransitionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Transition {
    var list: std.ArrayList(Transition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTransition(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAbacStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AbacStatus {
    _ = alloc;
    var result: AbacStatus = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(BucketAbacStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAbortIncompleteMultipartUpload(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AbortIncompleteMultipartUpload {
    _ = alloc;
    var result: AbortIncompleteMultipartUpload = undefined;
    result.days_after_initiation = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DaysAfterInitiation")) {
                    result.days_after_initiation = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAccessControlTranslation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessControlTranslation {
    _ = alloc;
    var result: AccessControlTranslation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = std.meta.stringToEnum(OwnerOverride, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnalyticsConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnalyticsConfiguration {
    var result: AnalyticsConfiguration = undefined;
    result.filter = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    try reader.skipElement();
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageClassAnalysis")) {
                    result.storage_class_analysis = try deserializeStorageClassAnalysis(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnalyticsExportDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnalyticsExportDestination {
    var result: AnalyticsExportDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s_3_bucket_destination = try deserializeAnalyticsS3BucketDestination(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnalyticsS3BucketDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnalyticsS3BucketDestination {
    var result: AnalyticsS3BucketDestination = undefined;
    result.bucket_account_id = null;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(AnalyticsS3ExportFileFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBlockedEncryptionTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BlockedEncryptionTypes {
    var result: BlockedEncryptionTypes = undefined;
    result.encryption_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EncryptionType")) {
                    result.encryption_type = try deserializeEncryptionTypeList(reader, alloc, "EncryptionType");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBucket(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Bucket {
    var result: Bucket = undefined;
    result.bucket_arn = null;
    result.bucket_region = null;
    result.creation_date = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketArn")) {
                    result.bucket_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketRegion")) {
                    result.bucket_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCORSRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CORSRule {
    var result: CORSRule = undefined;
    result.allowed_headers = null;
    result.expose_headers = null;
    result.id = null;
    result.max_age_seconds = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedHeader")) {
                    result.allowed_headers = try deserializeAllowedHeaders(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AllowedMethod")) {
                    result.allowed_methods = try deserializeAllowedMethods(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AllowedOrigin")) {
                    result.allowed_origins = try deserializeAllowedOrigins(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ExposeHeader")) {
                    result.expose_headers = try deserializeExposeHeaders(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxAgeSeconds")) {
                    result.max_age_seconds = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeChecksum(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Checksum {
    var result: Checksum = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.checksum_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = std.meta.stringToEnum(ChecksumType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCommonPrefix(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CommonPrefix {
    var result: CommonPrefix = undefined;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCondition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Condition {
    var result: Condition = undefined;
    result.http_error_code_returned_equals = null;
    result.key_prefix_equals = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HttpErrorCodeReturnedEquals")) {
                    result.http_error_code_returned_equals = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyPrefixEquals")) {
                    result.key_prefix_equals = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCopyObjectResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CopyObjectResult {
    var result: CopyObjectResult = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.checksum_type = null;
    result.e_tag = null;
    result.last_modified = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = std.meta.stringToEnum(ChecksumType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCopyPartResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CopyPartResult {
    var result: CopyPartResult = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.e_tag = null;
    result.last_modified = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDefaultRetention(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DefaultRetention {
    _ = alloc;
    var result: DefaultRetention = undefined;
    result.days = null;
    result.mode = null;
    result.years = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Days")) {
                    result.days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = std.meta.stringToEnum(ObjectLockRetentionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Years")) {
                    result.years = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeleteMarkerEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeleteMarkerEntry {
    var result: DeleteMarkerEntry = undefined;
    result.is_latest = null;
    result.key = null;
    result.last_modified = null;
    result.owner = null;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsLatest")) {
                    result.is_latest = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeleteMarkerReplication(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeleteMarkerReplication {
    _ = alloc;
    var result: DeleteMarkerReplication = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(DeleteMarkerReplicationStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeletedObject(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeletedObject {
    var result: DeletedObject = undefined;
    result.delete_marker = null;
    result.delete_marker_version_id = null;
    result.key = null;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteMarker")) {
                    result.delete_marker = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DeleteMarkerVersionId")) {
                    result.delete_marker_version_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Destination {
    var result: Destination = undefined;
    result.access_control_translation = null;
    result.account = null;
    result.encryption_configuration = null;
    result.metrics = null;
    result.replication_time = null;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlTranslation")) {
                    result.access_control_translation = try deserializeAccessControlTranslation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Account")) {
                    result.account = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncryptionConfiguration")) {
                    result.encryption_configuration = try deserializeEncryptionConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ReplicationTime")) {
                    result.replication_time = try deserializeReplicationTime(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(StorageClass, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDestinationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DestinationResult {
    var result: DestinationResult = undefined;
    result.table_bucket_arn = null;
    result.table_bucket_type = null;
    result.table_namespace = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TableBucketArn")) {
                    result.table_bucket_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableBucketType")) {
                    result.table_bucket_type = std.meta.stringToEnum(S3TablesBucketType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableNamespace")) {
                    result.table_namespace = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEncryptionConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EncryptionConfiguration {
    var result: EncryptionConfiguration = undefined;
    result.replica_kms_key_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReplicaKmsKeyID")) {
                    result.replica_kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeError(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Error {
    var result: Error = undefined;
    result.code = null;
    result.key = null;
    result.message = null;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeErrorDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ErrorDetails {
    var result: ErrorDetails = undefined;
    result.error_code = null;
    result.error_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeErrorDocument(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ErrorDocument {
    var result: ErrorDocument = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEventBridgeConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EventBridgeConfiguration {
    _ = alloc;
    const result: EventBridgeConfiguration = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |_| {
                try reader.skipElement();
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeExistingObjectReplication(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ExistingObjectReplication {
    _ = alloc;
    var result: ExistingObjectReplication = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ExistingObjectReplicationStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFilterRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FilterRule {
    var result: FilterRule = undefined;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = std.meta.stringToEnum(FilterRuleName, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGetBucketMetadataConfigurationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GetBucketMetadataConfigurationResult {
    var result: GetBucketMetadataConfigurationResult = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetadataConfigurationResult")) {
                    result.metadata_configuration_result = try deserializeMetadataConfigurationResult(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGetBucketMetadataTableConfigurationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GetBucketMetadataTableConfigurationResult {
    var result: GetBucketMetadataTableConfigurationResult = undefined;
    result.@"error" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try deserializeErrorDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MetadataTableConfigurationResult")) {
                    result.metadata_table_configuration_result = try deserializeMetadataTableConfigurationResult(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGetObjectAttributesParts(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GetObjectAttributesParts {
    var result: GetObjectAttributesParts = undefined;
    result.is_truncated = null;
    result.max_parts = null;
    result.next_part_number_marker = null;
    result.part_number_marker = null;
    result.parts = null;
    result.total_parts_count = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxParts")) {
                    result.max_parts = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NextPartNumberMarker")) {
                    result.next_part_number_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PartNumberMarker")) {
                    result.part_number_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Part")) {
                    result.parts = try deserializePartsList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PartsCount")) {
                    result.total_parts_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGrant(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Grant {
    var result: Grant = undefined;
    result.grantee = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeGrantee(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = std.meta.stringToEnum(Permission, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGrantee(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Grantee {
    var result: Grantee = undefined;
    result.display_name = null;
    result.email_address = null;
    result.id = null;
    result.uri = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EmailAddress")) {
                    result.email_address = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "xsi:type")) {
                    result.@"type" = std.meta.stringToEnum(Type, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "URI")) {
                    result.uri = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIndexDocument(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IndexDocument {
    var result: IndexDocument = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Suffix")) {
                    result.suffix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInitiator(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Initiator {
    var result: Initiator = undefined;
    result.display_name = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIntelligentTieringAndOperator(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IntelligentTieringAndOperator {
    var result: IntelligentTieringAndOperator = undefined;
    result.prefix = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tags = try deserializeTagSet(reader, alloc, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIntelligentTieringConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IntelligentTieringConfiguration {
    var result: IntelligentTieringConfiguration = undefined;
    result.filter = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeIntelligentTieringFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(IntelligentTieringStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tiering")) {
                    result.tierings = try deserializeTieringList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIntelligentTieringFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IntelligentTieringFilter {
    var result: IntelligentTieringFilter = undefined;
    result.@"and" = null;
    result.prefix = null;
    result.tag = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "And")) {
                    result.@"and" = try deserializeIntelligentTieringAndOperator(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tag = try deserializeTag(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInventoryConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InventoryConfiguration {
    var result: InventoryConfiguration = undefined;
    result.filter = null;
    result.optional_fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeInventoryDestination(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeInventoryFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IncludedObjectVersions")) {
                    result.included_object_versions = std.meta.stringToEnum(InventoryIncludedObjectVersions, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OptionalFields")) {
                    result.optional_fields = try deserializeInventoryOptionalFields(reader, alloc, "Field");
                } else if (std.mem.eql(u8, e.local, "Schedule")) {
                    result.schedule = try deserializeInventorySchedule(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInventoryDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InventoryDestination {
    var result: InventoryDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s_3_bucket_destination = try deserializeInventoryS3BucketDestination(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInventoryEncryption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InventoryEncryption {
    var result: InventoryEncryption = undefined;
    result.ssekms = null;
    result.sses3 = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SSE-KMS")) {
                    result.ssekms = try deserializeSSEKMS(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SSE-S3")) {
                    result.sses3 = try deserializeSSES3(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInventoryFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InventoryFilter {
    var result: InventoryFilter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInventoryS3BucketDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InventoryS3BucketDestination {
    var result: InventoryS3BucketDestination = undefined;
    result.account_id = null;
    result.encryption = null;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Encryption")) {
                    result.encryption = try deserializeInventoryEncryption(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(InventoryFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInventorySchedule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InventorySchedule {
    _ = alloc;
    var result: InventorySchedule = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Frequency")) {
                    result.frequency = std.meta.stringToEnum(InventoryFrequency, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInventoryTableConfigurationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InventoryTableConfigurationResult {
    var result: InventoryTableConfigurationResult = undefined;
    result.@"error" = null;
    result.table_arn = null;
    result.table_name = null;
    result.table_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConfigurationState")) {
                    result.configuration_state = std.meta.stringToEnum(InventoryConfigurationState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try deserializeErrorDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TableArn")) {
                    result.table_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableName")) {
                    result.table_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableStatus")) {
                    result.table_status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJournalTableConfigurationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JournalTableConfigurationResult {
    var result: JournalTableConfigurationResult = undefined;
    result.@"error" = null;
    result.table_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try deserializeErrorDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RecordExpiration")) {
                    result.record_expiration = try deserializeRecordExpiration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TableArn")) {
                    result.table_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableName")) {
                    result.table_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableStatus")) {
                    result.table_status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLambdaFunctionConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LambdaFunctionConfiguration {
    var result: LambdaFunctionConfiguration = undefined;
    result.filter = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Event")) {
                    result.events = try deserializeEventList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeNotificationConfigurationFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloudFunction")) {
                    result.lambda_function_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLifecycleExpiration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LifecycleExpiration {
    _ = alloc;
    var result: LifecycleExpiration = undefined;
    result.date = null;
    result.days = null;
    result.expired_object_delete_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Days")) {
                    result.days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ExpiredObjectDeleteMarker")) {
                    result.expired_object_delete_marker = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLifecycleRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LifecycleRule {
    var result: LifecycleRule = undefined;
    result.abort_incomplete_multipart_upload = null;
    result.expiration = null;
    result.filter = null;
    result.id = null;
    result.noncurrent_version_expiration = null;
    result.noncurrent_version_transitions = null;
    result.prefix = null;
    result.transitions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AbortIncompleteMultipartUpload")) {
                    result.abort_incomplete_multipart_upload = try deserializeAbortIncompleteMultipartUpload(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = try deserializeLifecycleExpiration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeLifecycleRuleFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NoncurrentVersionExpiration")) {
                    result.noncurrent_version_expiration = try deserializeNoncurrentVersionExpiration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NoncurrentVersionTransition")) {
                    result.noncurrent_version_transitions = try deserializeNoncurrentVersionTransitionList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ExpirationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Transition")) {
                    result.transitions = try deserializeTransitionList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLifecycleRuleAndOperator(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LifecycleRuleAndOperator {
    var result: LifecycleRuleAndOperator = undefined;
    result.object_size_greater_than = null;
    result.object_size_less_than = null;
    result.prefix = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ObjectSizeGreaterThan")) {
                    result.object_size_greater_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ObjectSizeLessThan")) {
                    result.object_size_less_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tags = try deserializeTagSet(reader, alloc, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLifecycleRuleFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LifecycleRuleFilter {
    var result: LifecycleRuleFilter = undefined;
    result.@"and" = null;
    result.object_size_greater_than = null;
    result.object_size_less_than = null;
    result.prefix = null;
    result.tag = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "And")) {
                    result.@"and" = try deserializeLifecycleRuleAndOperator(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ObjectSizeGreaterThan")) {
                    result.object_size_greater_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ObjectSizeLessThan")) {
                    result.object_size_less_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tag = try deserializeTag(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoggingEnabled(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoggingEnabled {
    var result: LoggingEnabled = undefined;
    result.target_grants = null;
    result.target_object_key_format = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetBucket")) {
                    result.target_bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGrants")) {
                    result.target_grants = try deserializeTargetGrants(reader, alloc, "Grant");
                } else if (std.mem.eql(u8, e.local, "TargetObjectKeyFormat")) {
                    result.target_object_key_format = try deserializeTargetObjectKeyFormat(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TargetPrefix")) {
                    result.target_prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetadataConfigurationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetadataConfigurationResult {
    var result: MetadataConfigurationResult = undefined;
    result.inventory_table_configuration_result = null;
    result.journal_table_configuration_result = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DestinationResult")) {
                    result.destination_result = try deserializeDestinationResult(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "InventoryTableConfigurationResult")) {
                    result.inventory_table_configuration_result = try deserializeInventoryTableConfigurationResult(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "JournalTableConfigurationResult")) {
                    result.journal_table_configuration_result = try deserializeJournalTableConfigurationResult(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetadataTableConfigurationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetadataTableConfigurationResult {
    var result: MetadataTableConfigurationResult = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3TablesDestinationResult")) {
                    result.s_3_tables_destination_result = try deserializeS3TablesDestinationResult(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Metrics {
    var result: Metrics = undefined;
    result.event_threshold = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventThreshold")) {
                    result.event_threshold = try deserializeReplicationTimeValue(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(MetricsStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricsConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricsConfiguration {
    var result: MetricsConfiguration = undefined;
    result.filter = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    try reader.skipElement();
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMultipartUpload(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MultipartUpload {
    var result: MultipartUpload = undefined;
    result.checksum_algorithm = null;
    result.checksum_type = null;
    result.initiated = null;
    result.initiator = null;
    result.key = null;
    result.owner = null;
    result.storage_class = null;
    result.upload_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = std.meta.stringToEnum(ChecksumAlgorithm, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = std.meta.stringToEnum(ChecksumType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Initiated")) {
                    result.initiated = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Initiator")) {
                    result.initiator = try deserializeInitiator(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(StorageClass, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadId")) {
                    result.upload_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNoncurrentVersionExpiration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NoncurrentVersionExpiration {
    _ = alloc;
    var result: NoncurrentVersionExpiration = undefined;
    result.newer_noncurrent_versions = null;
    result.noncurrent_days = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NewerNoncurrentVersions")) {
                    result.newer_noncurrent_versions = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NoncurrentDays")) {
                    result.noncurrent_days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNoncurrentVersionTransition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NoncurrentVersionTransition {
    _ = alloc;
    var result: NoncurrentVersionTransition = undefined;
    result.newer_noncurrent_versions = null;
    result.noncurrent_days = null;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NewerNoncurrentVersions")) {
                    result.newer_noncurrent_versions = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NoncurrentDays")) {
                    result.noncurrent_days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(TransitionStorageClass, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNotificationConfigurationFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NotificationConfigurationFilter {
    var result: NotificationConfigurationFilter = undefined;
    result.key = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3Key")) {
                    result.key = try deserializeS3KeyFilter(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObject(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Object {
    var result: Object = undefined;
    result.checksum_algorithm = null;
    result.checksum_type = null;
    result.e_tag = null;
    result.key = null;
    result.last_modified = null;
    result.owner = null;
    result.restore_status = null;
    result.size = null;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = try deserializeChecksumAlgorithmList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = std.meta.stringToEnum(ChecksumType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RestoreStatus")) {
                    result.restore_status = try deserializeRestoreStatus(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(ObjectStorageClass, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectLockConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLockConfiguration {
    var result: ObjectLockConfiguration = undefined;
    result.object_lock_enabled = null;
    result.rule = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ObjectLockEnabled")) {
                    result.object_lock_enabled = std.meta.stringToEnum(ObjectLockEnabled, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rule = try deserializeObjectLockRule(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectLockLegalHold(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLockLegalHold {
    _ = alloc;
    var result: ObjectLockLegalHold = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ObjectLockLegalHoldStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectLockRetention(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLockRetention {
    _ = alloc;
    var result: ObjectLockRetention = undefined;
    result.mode = null;
    result.retain_until_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = std.meta.stringToEnum(ObjectLockRetentionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RetainUntilDate")) {
                    result.retain_until_date = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectLockRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLockRule {
    var result: ObjectLockRule = undefined;
    result.default_retention = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultRetention")) {
                    result.default_retention = try deserializeDefaultRetention(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectPart(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectPart {
    var result: ObjectPart = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.part_number = null;
    result.size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PartNumber")) {
                    result.part_number = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectVersion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectVersion {
    var result: ObjectVersion = undefined;
    result.checksum_algorithm = null;
    result.checksum_type = null;
    result.e_tag = null;
    result.is_latest = null;
    result.key = null;
    result.last_modified = null;
    result.owner = null;
    result.restore_status = null;
    result.size = null;
    result.storage_class = null;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = try deserializeChecksumAlgorithmList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = std.meta.stringToEnum(ChecksumType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsLatest")) {
                    result.is_latest = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RestoreStatus")) {
                    result.restore_status = try deserializeRestoreStatus(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(ObjectVersionStorageClass, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOwner(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Owner {
    var result: Owner = undefined;
    result.display_name = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOwnershipControls(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OwnershipControls {
    var result: OwnershipControls = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rules = try deserializeOwnershipControlsRules(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOwnershipControlsRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OwnershipControlsRule {
    _ = alloc;
    var result: OwnershipControlsRule = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ObjectOwnership")) {
                    result.object_ownership = std.meta.stringToEnum(ObjectOwnership, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePart(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Part {
    var result: Part = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.e_tag = null;
    result.last_modified = null;
    result.part_number = null;
    result.size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PartNumber")) {
                    result.part_number = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePartitionedPrefix(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PartitionedPrefix {
    _ = alloc;
    var result: PartitionedPrefix = undefined;
    result.partition_date_source = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PartitionDateSource")) {
                    result.partition_date_source = std.meta.stringToEnum(PartitionDateSource, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyStatus {
    _ = alloc;
    var result: PolicyStatus = undefined;
    result.is_public = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsPublic")) {
                    result.is_public = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePublicAccessBlockConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PublicAccessBlockConfiguration {
    _ = alloc;
    var result: PublicAccessBlockConfiguration = undefined;
    result.block_public_acls = null;
    result.block_public_policy = null;
    result.ignore_public_acls = null;
    result.restrict_public_buckets = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BlockPublicAcls")) {
                    result.block_public_acls = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "BlockPublicPolicy")) {
                    result.block_public_policy = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IgnorePublicAcls")) {
                    result.ignore_public_acls = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RestrictPublicBuckets")) {
                    result.restrict_public_buckets = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueueConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueueConfiguration {
    var result: QueueConfiguration = undefined;
    result.filter = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Event")) {
                    result.events = try deserializeEventList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeNotificationConfigurationFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Queue")) {
                    result.queue_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRecordExpiration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RecordExpiration {
    _ = alloc;
    var result: RecordExpiration = undefined;
    result.days = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Days")) {
                    result.days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = std.meta.stringToEnum(ExpirationState, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRedirect(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Redirect {
    var result: Redirect = undefined;
    result.host_name = null;
    result.http_redirect_code = null;
    result.protocol = null;
    result.replace_key_prefix_with = null;
    result.replace_key_with = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostName")) {
                    result.host_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpRedirectCode")) {
                    result.http_redirect_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = std.meta.stringToEnum(Protocol, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplaceKeyPrefixWith")) {
                    result.replace_key_prefix_with = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplaceKeyWith")) {
                    result.replace_key_with = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRedirectAllRequestsTo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RedirectAllRequestsTo {
    var result: RedirectAllRequestsTo = undefined;
    result.protocol = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostName")) {
                    result.host_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = std.meta.stringToEnum(Protocol, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicaModifications(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicaModifications {
    _ = alloc;
    var result: ReplicaModifications = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ReplicaModificationsStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationConfiguration {
    var result: ReplicationConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rules = try deserializeReplicationRules(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationRule {
    var result: ReplicationRule = undefined;
    result.delete_marker_replication = null;
    result.existing_object_replication = null;
    result.filter = null;
    result.id = null;
    result.prefix = null;
    result.priority = null;
    result.source_selection_criteria = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteMarkerReplication")) {
                    result.delete_marker_replication = try deserializeDeleteMarkerReplication(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeDestination(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ExistingObjectReplication")) {
                    result.existing_object_replication = try deserializeExistingObjectReplication(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeReplicationRuleFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceSelectionCriteria")) {
                    result.source_selection_criteria = try deserializeSourceSelectionCriteria(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ReplicationRuleStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationRuleAndOperator(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationRuleAndOperator {
    var result: ReplicationRuleAndOperator = undefined;
    result.prefix = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tags = try deserializeTagSet(reader, alloc, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationRuleFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationRuleFilter {
    var result: ReplicationRuleFilter = undefined;
    result.@"and" = null;
    result.prefix = null;
    result.tag = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "And")) {
                    result.@"and" = try deserializeReplicationRuleAndOperator(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tag = try deserializeTag(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationTime(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationTime {
    var result: ReplicationTime = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ReplicationTimeStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Time")) {
                    result.time = try deserializeReplicationTimeValue(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationTimeValue(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationTimeValue {
    _ = alloc;
    var result: ReplicationTimeValue = undefined;
    result.minutes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Minutes")) {
                    result.minutes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRestoreStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RestoreStatus {
    _ = alloc;
    var result: RestoreStatus = undefined;
    result.is_restore_in_progress = null;
    result.restore_expiry_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsRestoreInProgress")) {
                    result.is_restore_in_progress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RestoreExpiryDate")) {
                    result.restore_expiry_date = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRoutingRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RoutingRule {
    var result: RoutingRule = undefined;
    result.condition = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Condition")) {
                    result.condition = try deserializeCondition(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Redirect")) {
                    result.redirect = try deserializeRedirect(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3KeyFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3KeyFilter {
    var result: S3KeyFilter = undefined;
    result.filter_rules = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FilterRule")) {
                    result.filter_rules = try deserializeFilterRuleList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3TablesDestinationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3TablesDestinationResult {
    var result: S3TablesDestinationResult = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TableArn")) {
                    result.table_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableBucketArn")) {
                    result.table_bucket_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableName")) {
                    result.table_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableNamespace")) {
                    result.table_namespace = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSSEKMS(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SSEKMS {
    var result: SSEKMS = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyId")) {
                    result.key_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSSES3(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SSES3 {
    _ = alloc;
    const result: SSES3 = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |_| {
                try reader.skipElement();
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerSideEncryptionByDefault(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerSideEncryptionByDefault {
    var result: ServerSideEncryptionByDefault = undefined;
    result.kms_master_key_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KMSMasterKeyID")) {
                    result.kms_master_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSEAlgorithm")) {
                    result.sse_algorithm = std.meta.stringToEnum(ServerSideEncryption, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerSideEncryptionConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerSideEncryptionConfiguration {
    var result: ServerSideEncryptionConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rules = try deserializeServerSideEncryptionRules(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerSideEncryptionRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerSideEncryptionRule {
    var result: ServerSideEncryptionRule = undefined;
    result.apply_server_side_encryption_by_default = null;
    result.blocked_encryption_types = null;
    result.bucket_key_enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplyServerSideEncryptionByDefault")) {
                    result.apply_server_side_encryption_by_default = try deserializeServerSideEncryptionByDefault(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "BlockedEncryptionTypes")) {
                    result.blocked_encryption_types = try deserializeBlockedEncryptionTypes(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "BucketKeyEnabled")) {
                    result.bucket_key_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSessionCredentials(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SessionCredentials {
    var result: SessionCredentials = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = try aws.imds.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretAccessKey")) {
                    result.secret_access_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionToken")) {
                    result.session_token = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSimplePrefix(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SimplePrefix {
    _ = alloc;
    const result: SimplePrefix = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |_| {
                try reader.skipElement();
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSourceSelectionCriteria(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SourceSelectionCriteria {
    var result: SourceSelectionCriteria = undefined;
    result.replica_modifications = null;
    result.sse_kms_encrypted_objects = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReplicaModifications")) {
                    result.replica_modifications = try deserializeReplicaModifications(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SseKmsEncryptedObjects")) {
                    result.sse_kms_encrypted_objects = try deserializeSseKmsEncryptedObjects(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSseKmsEncryptedObjects(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SseKmsEncryptedObjects {
    _ = alloc;
    var result: SseKmsEncryptedObjects = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(SseKmsEncryptedObjectsStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageClassAnalysis(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageClassAnalysis {
    var result: StorageClassAnalysis = undefined;
    result.data_export = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DataExport")) {
                    result.data_export = try deserializeStorageClassAnalysisDataExport(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageClassAnalysisDataExport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageClassAnalysisDataExport {
    var result: StorageClassAnalysisDataExport = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeAnalyticsExportDestination(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "OutputSchemaVersion")) {
                    result.output_schema_version = std.meta.stringToEnum(StorageClassAnalysisSchemaVersion, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tag {
    var result: Tag = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetGrant(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetGrant {
    var result: TargetGrant = undefined;
    result.grantee = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeGrantee(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = std.meta.stringToEnum(BucketLogsPermission, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetObjectKeyFormat(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetObjectKeyFormat {
    var result: TargetObjectKeyFormat = undefined;
    result.partitioned_prefix = null;
    result.simple_prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PartitionedPrefix")) {
                    result.partitioned_prefix = try deserializePartitionedPrefix(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SimplePrefix")) {
                    result.simple_prefix = try deserializeSimplePrefix(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTiering(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tiering {
    _ = alloc;
    var result: Tiering = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessTier")) {
                    result.access_tier = std.meta.stringToEnum(IntelligentTieringAccessTier, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Days")) {
                    result.days = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTopicConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TopicConfiguration {
    var result: TopicConfiguration = undefined;
    result.filter = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Event")) {
                    result.events = try deserializeEventList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeNotificationConfigurationFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Topic")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTransition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Transition {
    _ = alloc;
    var result: Transition = undefined;
    result.date = null;
    result.days = null;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Days")) {
                    result.days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(TransitionStorageClass, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

