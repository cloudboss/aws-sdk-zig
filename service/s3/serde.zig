const aws = @import("aws");
const std = @import("std");

const AbacStatus = @import("abac_status.zig").AbacStatus;
const AbortIncompleteMultipartUpload = @import("abort_incomplete_multipart_upload.zig").AbortIncompleteMultipartUpload;
const AccelerateConfiguration = @import("accelerate_configuration.zig").AccelerateConfiguration;
const AccessControlPolicy = @import("access_control_policy.zig").AccessControlPolicy;
const AccessControlTranslation = @import("access_control_translation.zig").AccessControlTranslation;
const AnalyticsConfiguration = @import("analytics_configuration.zig").AnalyticsConfiguration;
const AnalyticsExportDestination = @import("analytics_export_destination.zig").AnalyticsExportDestination;
const AnalyticsS3BucketDestination = @import("analytics_s3_bucket_destination.zig").AnalyticsS3BucketDestination;
const AnalyticsS3ExportFileFormat = @import("analytics_s3_export_file_format.zig").AnalyticsS3ExportFileFormat;
const BlockedEncryptionTypes = @import("blocked_encryption_types.zig").BlockedEncryptionTypes;
const Bucket = @import("bucket.zig").Bucket;
const BucketAbacStatus = @import("bucket_abac_status.zig").BucketAbacStatus;
const BucketAccelerateStatus = @import("bucket_accelerate_status.zig").BucketAccelerateStatus;
const BucketInfo = @import("bucket_info.zig").BucketInfo;
const BucketLifecycleConfiguration = @import("bucket_lifecycle_configuration.zig").BucketLifecycleConfiguration;
const BucketLocationConstraint = @import("bucket_location_constraint.zig").BucketLocationConstraint;
const BucketLoggingStatus = @import("bucket_logging_status.zig").BucketLoggingStatus;
const BucketLogsPermission = @import("bucket_logs_permission.zig").BucketLogsPermission;
const BucketType = @import("bucket_type.zig").BucketType;
const BucketVersioningStatus = @import("bucket_versioning_status.zig").BucketVersioningStatus;
const CORSConfiguration = @import("cors_configuration.zig").CORSConfiguration;
const CORSRule = @import("cors_rule.zig").CORSRule;
const CSVInput = @import("csv_input.zig").CSVInput;
const CSVOutput = @import("csv_output.zig").CSVOutput;
const Checksum = @import("checksum.zig").Checksum;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const CommonPrefix = @import("common_prefix.zig").CommonPrefix;
const CompletedMultipartUpload = @import("completed_multipart_upload.zig").CompletedMultipartUpload;
const CompletedPart = @import("completed_part.zig").CompletedPart;
const CompressionType = @import("compression_type.zig").CompressionType;
const Condition = @import("condition.zig").Condition;
const CopyObjectResult = @import("copy_object_result.zig").CopyObjectResult;
const CopyPartResult = @import("copy_part_result.zig").CopyPartResult;
const CreateBucketConfiguration = @import("create_bucket_configuration.zig").CreateBucketConfiguration;
const DataRedundancy = @import("data_redundancy.zig").DataRedundancy;
const DefaultRetention = @import("default_retention.zig").DefaultRetention;
const Delete = @import("delete.zig").Delete;
const DeleteMarkerEntry = @import("delete_marker_entry.zig").DeleteMarkerEntry;
const DeleteMarkerReplication = @import("delete_marker_replication.zig").DeleteMarkerReplication;
const DeleteMarkerReplicationStatus = @import("delete_marker_replication_status.zig").DeleteMarkerReplicationStatus;
const DeletedObject = @import("deleted_object.zig").DeletedObject;
const Destination = @import("destination.zig").Destination;
const DestinationResult = @import("destination_result.zig").DestinationResult;
const Encryption = @import("encryption.zig").Encryption;
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
const ExpressionType = @import("expression_type.zig").ExpressionType;
const FileHeaderInfo = @import("file_header_info.zig").FileHeaderInfo;
const FilterRule = @import("filter_rule.zig").FilterRule;
const FilterRuleName = @import("filter_rule_name.zig").FilterRuleName;
const GetBucketMetadataConfigurationResult = @import("get_bucket_metadata_configuration_result.zig").GetBucketMetadataConfigurationResult;
const GetBucketMetadataTableConfigurationResult = @import("get_bucket_metadata_table_configuration_result.zig").GetBucketMetadataTableConfigurationResult;
const GetObjectAttributesParts = @import("get_object_attributes_parts.zig").GetObjectAttributesParts;
const GlacierJobParameters = @import("glacier_job_parameters.zig").GlacierJobParameters;
const Grant = @import("grant.zig").Grant;
const Grantee = @import("grantee.zig").Grantee;
const IndexDocument = @import("index_document.zig").IndexDocument;
const Initiator = @import("initiator.zig").Initiator;
const InputSerialization = @import("input_serialization.zig").InputSerialization;
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
const InventoryS3BucketDestination = @import("inventory_s3_bucket_destination.zig").InventoryS3BucketDestination;
const InventorySchedule = @import("inventory_schedule.zig").InventorySchedule;
const InventoryTableConfiguration = @import("inventory_table_configuration.zig").InventoryTableConfiguration;
const InventoryTableConfigurationResult = @import("inventory_table_configuration_result.zig").InventoryTableConfigurationResult;
const InventoryTableConfigurationUpdates = @import("inventory_table_configuration_updates.zig").InventoryTableConfigurationUpdates;
const JSONInput = @import("json_input.zig").JSONInput;
const JSONOutput = @import("json_output.zig").JSONOutput;
const JSONType = @import("json_type.zig").JSONType;
const JournalTableConfiguration = @import("journal_table_configuration.zig").JournalTableConfiguration;
const JournalTableConfigurationResult = @import("journal_table_configuration_result.zig").JournalTableConfigurationResult;
const JournalTableConfigurationUpdates = @import("journal_table_configuration_updates.zig").JournalTableConfigurationUpdates;
const LambdaFunctionConfiguration = @import("lambda_function_configuration.zig").LambdaFunctionConfiguration;
const LifecycleExpiration = @import("lifecycle_expiration.zig").LifecycleExpiration;
const LifecycleRule = @import("lifecycle_rule.zig").LifecycleRule;
const LifecycleRuleAndOperator = @import("lifecycle_rule_and_operator.zig").LifecycleRuleAndOperator;
const LifecycleRuleFilter = @import("lifecycle_rule_filter.zig").LifecycleRuleFilter;
const LocationInfo = @import("location_info.zig").LocationInfo;
const LocationType = @import("location_type.zig").LocationType;
const LoggingEnabled = @import("logging_enabled.zig").LoggingEnabled;
const MFADelete = @import("mfa_delete.zig").MFADelete;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;
const MetadataConfigurationResult = @import("metadata_configuration_result.zig").MetadataConfigurationResult;
const MetadataEntry = @import("metadata_entry.zig").MetadataEntry;
const MetadataTableConfiguration = @import("metadata_table_configuration.zig").MetadataTableConfiguration;
const MetadataTableConfigurationResult = @import("metadata_table_configuration_result.zig").MetadataTableConfigurationResult;
const MetadataTableEncryptionConfiguration = @import("metadata_table_encryption_configuration.zig").MetadataTableEncryptionConfiguration;
const Metrics = @import("metrics.zig").Metrics;
const MetricsConfiguration = @import("metrics_configuration.zig").MetricsConfiguration;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const MultipartUpload = @import("multipart_upload.zig").MultipartUpload;
const NoncurrentVersionExpiration = @import("noncurrent_version_expiration.zig").NoncurrentVersionExpiration;
const NoncurrentVersionTransition = @import("noncurrent_version_transition.zig").NoncurrentVersionTransition;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const NotificationConfigurationFilter = @import("notification_configuration_filter.zig").NotificationConfigurationFilter;
const Object = @import("object.zig").Object;
const ObjectAttributes = @import("object_attributes.zig").ObjectAttributes;
const ObjectCannedACL = @import("object_canned_acl.zig").ObjectCannedACL;
const ObjectIdentifier = @import("object_identifier.zig").ObjectIdentifier;
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
const OptionalObjectAttributes = @import("optional_object_attributes.zig").OptionalObjectAttributes;
const OutputLocation = @import("output_location.zig").OutputLocation;
const OutputSerialization = @import("output_serialization.zig").OutputSerialization;
const Owner = @import("owner.zig").Owner;
const OwnerOverride = @import("owner_override.zig").OwnerOverride;
const OwnershipControls = @import("ownership_controls.zig").OwnershipControls;
const OwnershipControlsRule = @import("ownership_controls_rule.zig").OwnershipControlsRule;
const ParquetInput = @import("parquet_input.zig").ParquetInput;
const Part = @import("part.zig").Part;
const PartitionDateSource = @import("partition_date_source.zig").PartitionDateSource;
const PartitionedPrefix = @import("partitioned_prefix.zig").PartitionedPrefix;
const Payer = @import("payer.zig").Payer;
const Permission = @import("permission.zig").Permission;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;
const Protocol = @import("protocol.zig").Protocol;
const PublicAccessBlockConfiguration = @import("public_access_block_configuration.zig").PublicAccessBlockConfiguration;
const QueueConfiguration = @import("queue_configuration.zig").QueueConfiguration;
const QuoteFields = @import("quote_fields.zig").QuoteFields;
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
const RequestPaymentConfiguration = @import("request_payment_configuration.zig").RequestPaymentConfiguration;
const RequestProgress = @import("request_progress.zig").RequestProgress;
const RestoreRequest = @import("restore_request.zig").RestoreRequest;
const RestoreRequestType = @import("restore_request_type.zig").RestoreRequestType;
const RestoreStatus = @import("restore_status.zig").RestoreStatus;
const RoutingRule = @import("routing_rule.zig").RoutingRule;
const S3KeyFilter = @import("s3_key_filter.zig").S3KeyFilter;
const S3Location = @import("s3_location.zig").S3Location;
const S3TablesBucketType = @import("s3_tables_bucket_type.zig").S3TablesBucketType;
const S3TablesDestination = @import("s3_tables_destination.zig").S3TablesDestination;
const S3TablesDestinationResult = @import("s3_tables_destination_result.zig").S3TablesDestinationResult;
const SSEKMS = @import("ssekms.zig").SSEKMS;
const SSES3 = @import("sses3.zig").SSES3;
const ScanRange = @import("scan_range.zig").ScanRange;
const SelectParameters = @import("select_parameters.zig").SelectParameters;
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
const TableSseAlgorithm = @import("table_sse_algorithm.zig").TableSseAlgorithm;
const Tag = @import("tag.zig").Tag;
const Tagging = @import("tagging.zig").Tagging;
const TargetGrant = @import("target_grant.zig").TargetGrant;
const TargetObjectKeyFormat = @import("target_object_key_format.zig").TargetObjectKeyFormat;
const Tier = @import("tier.zig").Tier;
const Tiering = @import("tiering.zig").Tiering;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;
const Transition = @import("transition.zig").Transition;
const TransitionStorageClass = @import("transition_storage_class.zig").TransitionStorageClass;
const Type = @import("type.zig").Type;
const VersioningConfiguration = @import("versioning_configuration.zig").VersioningConfiguration;
const WebsiteConfiguration = @import("website_configuration.zig").WebsiteConfiguration;

pub fn deserializeAllowedHeaders(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAllowedMethods(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAllowedOrigins(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAnalyticsConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AnalyticsConfiguration {
    var list: std.ArrayList(AnalyticsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAnalyticsConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeBuckets(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Bucket {
    var list: std.ArrayList(Bucket) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBucket(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCORSRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CORSRule {
    var list: std.ArrayList(CORSRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCORSRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeChecksumAlgorithmList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ChecksumAlgorithm {
    var list: std.ArrayList(ChecksumAlgorithm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (ChecksumAlgorithm.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCommonPrefixList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CommonPrefix {
    var list: std.ArrayList(CommonPrefix) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCommonPrefix(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDeleteMarkers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DeleteMarkerEntry {
    var list: std.ArrayList(DeleteMarkerEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDeleteMarkerEntry(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDeletedObjects(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DeletedObject {
    var list: std.ArrayList(DeletedObject) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDeletedObject(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEncryptionTypeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EncryptionType {
    var list: std.ArrayList(EncryptionType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (EncryptionType.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeErrors(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Error {
    var list: std.ArrayList(Error) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeError(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEventList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Event {
    var list: std.ArrayList(Event) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (Event.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeExposeHeaders(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFilterRuleList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const FilterRule {
    var list: std.ArrayList(FilterRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeFilterRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeGrants(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Grant {
    var list: std.ArrayList(Grant) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGrant(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeIntelligentTieringConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const IntelligentTieringConfiguration {
    var list: std.ArrayList(IntelligentTieringConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeIntelligentTieringConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInventoryConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InventoryConfiguration {
    var list: std.ArrayList(InventoryConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInventoryConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInventoryOptionalFields(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InventoryOptionalField {
    var list: std.ArrayList(InventoryOptionalField) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (InventoryOptionalField.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLambdaFunctionConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LambdaFunctionConfiguration {
    var list: std.ArrayList(LambdaFunctionConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLambdaFunctionConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLifecycleRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LifecycleRule {
    var list: std.ArrayList(LifecycleRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLifecycleRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricsConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricsConfiguration {
    var list: std.ArrayList(MetricsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricsConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMultipartUploadList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MultipartUpload {
    var list: std.ArrayList(MultipartUpload) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMultipartUpload(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeNoncurrentVersionTransitionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NoncurrentVersionTransition {
    var list: std.ArrayList(NoncurrentVersionTransition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNoncurrentVersionTransition(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeObjectList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Object {
    var list: std.ArrayList(Object) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeObject(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeObjectVersionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ObjectVersion {
    var list: std.ArrayList(ObjectVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeObjectVersion(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOwnershipControlsRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OwnershipControlsRule {
    var list: std.ArrayList(OwnershipControlsRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOwnershipControlsRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeParts(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Part {
    var list: std.ArrayList(Part) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePart(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePartsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ObjectPart {
    var list: std.ArrayList(ObjectPart) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeObjectPart(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeQueueConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const QueueConfiguration {
    var list: std.ArrayList(QueueConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeQueueConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReplicationRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReplicationRule {
    var list: std.ArrayList(ReplicationRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReplicationRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRoutingRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RoutingRule {
    var list: std.ArrayList(RoutingRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRoutingRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeServerSideEncryptionRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServerSideEncryptionRule {
    var list: std.ArrayList(ServerSideEncryptionRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeServerSideEncryptionRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTagSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTargetGrants(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TargetGrant {
    var list: std.ArrayList(TargetGrant) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTargetGrant(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTieringList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tiering {
    var list: std.ArrayList(Tiering) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTiering(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTopicConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TopicConfiguration {
    var list: std.ArrayList(TopicConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTopicConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTransitionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Transition {
    var list: std.ArrayList(Transition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTransition(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
    var list: std.ArrayList(aws.map.StringMapEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: []const u8 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try allocator.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAbacStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AbacStatus {
    _ = allocator;
    var result: AbacStatus = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = BucketAbacStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeAbortIncompleteMultipartUpload(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AbortIncompleteMultipartUpload {
    _ = allocator;
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

pub fn deserializeAccessControlTranslation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessControlTranslation {
    _ = allocator;
    var result: AccessControlTranslation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = OwnerOverride.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeAnalyticsConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnalyticsConfiguration {
    var result: AnalyticsConfiguration = undefined;
    result.filter = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    try reader.skipElement();
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageClassAnalysis")) {
                    result.storage_class_analysis = try deserializeStorageClassAnalysis(allocator, reader);
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

pub fn deserializeAnalyticsExportDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnalyticsExportDestination {
    var result: AnalyticsExportDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s3_bucket_destination = try deserializeAnalyticsS3BucketDestination(allocator, reader);
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

pub fn deserializeAnalyticsS3BucketDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnalyticsS3BucketDestination {
    var result: AnalyticsS3BucketDestination = undefined;
    result.bucket_account_id = null;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = AnalyticsS3ExportFileFormat.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeBlockedEncryptionTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BlockedEncryptionTypes {
    var result: BlockedEncryptionTypes = undefined;
    result.encryption_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EncryptionType")) {
                    result.encryption_type = try deserializeEncryptionTypeList(allocator, reader, "EncryptionType");
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

pub fn deserializeBucket(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Bucket {
    var result: Bucket = undefined;
    result.bucket_arn = null;
    result.bucket_region = null;
    result.creation_date = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketArn")) {
                    result.bucket_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketRegion")) {
                    result.bucket_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCORSRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CORSRule {
    var result: CORSRule = undefined;
    result.allowed_headers = null;
    result.expose_headers = null;
    result.id = null;
    result.max_age_seconds = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedHeader")) {
                    result.allowed_headers = try deserializeAllowedHeaders(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AllowedMethod")) {
                    result.allowed_methods = try deserializeAllowedMethods(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AllowedOrigin")) {
                    result.allowed_origins = try deserializeAllowedOrigins(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ExposeHeader")) {
                    result.expose_headers = try deserializeExposeHeaders(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeChecksum(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Checksum {
    var result: Checksum = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_md5 = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.checksum_sha512 = null;
    result.checksum_type = null;
    result.checksum_xxhash128 = null;
    result.checksum_xxhash3 = null;
    result.checksum_xxhash64 = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumMD5")) {
                    result.checksum_md5 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA512")) {
                    result.checksum_sha512 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = ChecksumType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH128")) {
                    result.checksum_xxhash128 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH3")) {
                    result.checksum_xxhash3 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH64")) {
                    result.checksum_xxhash64 = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCommonPrefix(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CommonPrefix {
    var result: CommonPrefix = undefined;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCondition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Condition {
    var result: Condition = undefined;
    result.http_error_code_returned_equals = null;
    result.key_prefix_equals = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HttpErrorCodeReturnedEquals")) {
                    result.http_error_code_returned_equals = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyPrefixEquals")) {
                    result.key_prefix_equals = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCopyObjectResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CopyObjectResult {
    var result: CopyObjectResult = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_md5 = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.checksum_sha512 = null;
    result.checksum_type = null;
    result.checksum_xxhash128 = null;
    result.checksum_xxhash3 = null;
    result.checksum_xxhash64 = null;
    result.e_tag = null;
    result.last_modified = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumMD5")) {
                    result.checksum_md5 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA512")) {
                    result.checksum_sha512 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = ChecksumType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH128")) {
                    result.checksum_xxhash128 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH3")) {
                    result.checksum_xxhash3 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH64")) {
                    result.checksum_xxhash64 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeCopyPartResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CopyPartResult {
    var result: CopyPartResult = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_md5 = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.checksum_sha512 = null;
    result.checksum_xxhash128 = null;
    result.checksum_xxhash3 = null;
    result.checksum_xxhash64 = null;
    result.e_tag = null;
    result.last_modified = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumMD5")) {
                    result.checksum_md5 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA512")) {
                    result.checksum_sha512 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH128")) {
                    result.checksum_xxhash128 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH3")) {
                    result.checksum_xxhash3 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH64")) {
                    result.checksum_xxhash64 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeDefaultRetention(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DefaultRetention {
    _ = allocator;
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
                    result.mode = ObjectLockRetentionMode.fromWireName(try reader.readElementText());
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

pub fn deserializeDeleteMarkerEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeleteMarkerEntry {
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
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDeleteMarkerReplication(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeleteMarkerReplication {
    _ = allocator;
    var result: DeleteMarkerReplication = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = DeleteMarkerReplicationStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeDeletedObject(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeletedObject {
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
                    result.delete_marker_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Destination {
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
                    result.access_control_translation = try deserializeAccessControlTranslation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Account")) {
                    result.account = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncryptionConfiguration")) {
                    result.encryption_configuration = try deserializeEncryptionConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ReplicationTime")) {
                    result.replication_time = try deserializeReplicationTime(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = StorageClass.fromWireName(try reader.readElementText());
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

pub fn deserializeDestinationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DestinationResult {
    var result: DestinationResult = undefined;
    result.table_bucket_arn = null;
    result.table_bucket_type = null;
    result.table_namespace = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TableBucketArn")) {
                    result.table_bucket_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableBucketType")) {
                    result.table_bucket_type = S3TablesBucketType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableNamespace")) {
                    result.table_namespace = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeEncryptionConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EncryptionConfiguration {
    var result: EncryptionConfiguration = undefined;
    result.replica_kms_key_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReplicaKmsKeyID")) {
                    result.replica_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeError(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Error {
    var result: Error = undefined;
    result.code = null;
    result.key = null;
    result.message = null;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeErrorDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ErrorDetails {
    var result: ErrorDetails = undefined;
    result.error_code = null;
    result.error_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeErrorDocument(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ErrorDocument {
    var result: ErrorDocument = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeEventBridgeConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EventBridgeConfiguration {
    _ = allocator;
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

pub fn deserializeExistingObjectReplication(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ExistingObjectReplication {
    _ = allocator;
    var result: ExistingObjectReplication = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ExistingObjectReplicationStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeFilterRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FilterRule {
    var result: FilterRule = undefined;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = FilterRuleName.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeGetBucketMetadataConfigurationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GetBucketMetadataConfigurationResult {
    var result: GetBucketMetadataConfigurationResult = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetadataConfigurationResult")) {
                    result.metadata_configuration_result = try deserializeMetadataConfigurationResult(allocator, reader);
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

pub fn deserializeGetBucketMetadataTableConfigurationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GetBucketMetadataTableConfigurationResult {
    var result: GetBucketMetadataTableConfigurationResult = undefined;
    result.@"error" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try deserializeErrorDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MetadataTableConfigurationResult")) {
                    result.metadata_table_configuration_result = try deserializeMetadataTableConfigurationResult(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeGetObjectAttributesParts(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GetObjectAttributesParts {
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
                    result.next_part_number_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PartNumberMarker")) {
                    result.part_number_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Part")) {
                    result.parts = try deserializePartsList(allocator, reader, "member");
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

pub fn deserializeGrant(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Grant {
    var result: Grant = undefined;
    result.grantee = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeGrantee(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = Permission.fromWireName(try reader.readElementText());
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

pub fn deserializeGrantee(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Grantee {
    var result: Grantee = undefined;
    result.display_name = null;
    result.email_address = null;
    result.id = null;
    result.uri = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EmailAddress")) {
                    result.email_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "xsi:type")) {
                    result.@"type" = Type.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "URI")) {
                    result.uri = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeIndexDocument(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IndexDocument {
    var result: IndexDocument = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Suffix")) {
                    result.suffix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInitiator(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Initiator {
    var result: Initiator = undefined;
    result.display_name = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeIntelligentTieringAndOperator(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IntelligentTieringAndOperator {
    var result: IntelligentTieringAndOperator = undefined;
    result.prefix = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tags = try deserializeTagSet(allocator, reader, "Tag");
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

pub fn deserializeIntelligentTieringConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IntelligentTieringConfiguration {
    var result: IntelligentTieringConfiguration = undefined;
    result.filter = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeIntelligentTieringFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = IntelligentTieringStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Tiering")) {
                    result.tierings = try deserializeTieringList(allocator, reader, "member");
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

pub fn deserializeIntelligentTieringFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IntelligentTieringFilter {
    var result: IntelligentTieringFilter = undefined;
    result.@"and" = null;
    result.prefix = null;
    result.tag = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "And")) {
                    result.@"and" = try deserializeIntelligentTieringAndOperator(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tag = try deserializeTag(allocator, reader);
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

pub fn deserializeInventoryConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InventoryConfiguration {
    var result: InventoryConfiguration = undefined;
    result.filter = null;
    result.optional_fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeInventoryDestination(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeInventoryFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IncludedObjectVersions")) {
                    result.included_object_versions = InventoryIncludedObjectVersions.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OptionalFields")) {
                    result.optional_fields = try deserializeInventoryOptionalFields(allocator, reader, "Field");
                } else if (std.mem.eql(u8, e.local, "Schedule")) {
                    result.schedule = try deserializeInventorySchedule(allocator, reader);
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

pub fn deserializeInventoryDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InventoryDestination {
    var result: InventoryDestination = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s3_bucket_destination = try deserializeInventoryS3BucketDestination(allocator, reader);
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

pub fn deserializeInventoryEncryption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InventoryEncryption {
    var result: InventoryEncryption = undefined;
    result.ssekms = null;
    result.sses3 = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SSE-KMS")) {
                    result.ssekms = try deserializeSSEKMS(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SSE-S3")) {
                    result.sses3 = try deserializeSSES3(allocator, reader);
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

pub fn deserializeInventoryFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InventoryFilter {
    var result: InventoryFilter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInventoryS3BucketDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InventoryS3BucketDestination {
    var result: InventoryS3BucketDestination = undefined;
    result.account_id = null;
    result.encryption = null;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Encryption")) {
                    result.encryption = try deserializeInventoryEncryption(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = InventoryFormat.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInventorySchedule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InventorySchedule {
    _ = allocator;
    var result: InventorySchedule = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Frequency")) {
                    result.frequency = InventoryFrequency.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeInventoryTableConfigurationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InventoryTableConfigurationResult {
    var result: InventoryTableConfigurationResult = undefined;
    result.@"error" = null;
    result.table_arn = null;
    result.table_name = null;
    result.table_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConfigurationState")) {
                    result.configuration_state = InventoryConfigurationState.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try deserializeErrorDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TableArn")) {
                    result.table_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableName")) {
                    result.table_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableStatus")) {
                    result.table_status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeJournalTableConfigurationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JournalTableConfigurationResult {
    var result: JournalTableConfigurationResult = undefined;
    result.@"error" = null;
    result.table_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Error")) {
                    result.@"error" = try deserializeErrorDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RecordExpiration")) {
                    result.record_expiration = try deserializeRecordExpiration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TableArn")) {
                    result.table_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableName")) {
                    result.table_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableStatus")) {
                    result.table_status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLambdaFunctionConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LambdaFunctionConfiguration {
    var result: LambdaFunctionConfiguration = undefined;
    result.filter = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Event")) {
                    result.events = try deserializeEventList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeNotificationConfigurationFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloudFunction")) {
                    result.lambda_function_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLifecycleExpiration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LifecycleExpiration {
    _ = allocator;
    var result: LifecycleExpiration = undefined;
    result.date = null;
    result.days = null;
    result.expired_object_delete_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeLifecycleRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LifecycleRule {
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
                    result.abort_incomplete_multipart_upload = try deserializeAbortIncompleteMultipartUpload(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = try deserializeLifecycleExpiration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeLifecycleRuleFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NoncurrentVersionExpiration")) {
                    result.noncurrent_version_expiration = try deserializeNoncurrentVersionExpiration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NoncurrentVersionTransition")) {
                    result.noncurrent_version_transitions = try deserializeNoncurrentVersionTransitionList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ExpirationStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Transition")) {
                    result.transitions = try deserializeTransitionList(allocator, reader, "member");
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

pub fn deserializeLifecycleRuleAndOperator(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LifecycleRuleAndOperator {
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
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tags = try deserializeTagSet(allocator, reader, "Tag");
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

pub fn deserializeLifecycleRuleFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LifecycleRuleFilter {
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
                    result.@"and" = try deserializeLifecycleRuleAndOperator(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ObjectSizeGreaterThan")) {
                    result.object_size_greater_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ObjectSizeLessThan")) {
                    result.object_size_less_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tag = try deserializeTag(allocator, reader);
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

pub fn deserializeLoggingEnabled(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoggingEnabled {
    var result: LoggingEnabled = undefined;
    result.target_grants = null;
    result.target_object_key_format = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetBucket")) {
                    result.target_bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGrants")) {
                    result.target_grants = try deserializeTargetGrants(allocator, reader, "Grant");
                } else if (std.mem.eql(u8, e.local, "TargetObjectKeyFormat")) {
                    result.target_object_key_format = try deserializeTargetObjectKeyFormat(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TargetPrefix")) {
                    result.target_prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeMetadataConfigurationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetadataConfigurationResult {
    var result: MetadataConfigurationResult = undefined;
    result.inventory_table_configuration_result = null;
    result.journal_table_configuration_result = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DestinationResult")) {
                    result.destination_result = try deserializeDestinationResult(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "InventoryTableConfigurationResult")) {
                    result.inventory_table_configuration_result = try deserializeInventoryTableConfigurationResult(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "JournalTableConfigurationResult")) {
                    result.journal_table_configuration_result = try deserializeJournalTableConfigurationResult(allocator, reader);
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

pub fn deserializeMetadataTableConfigurationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetadataTableConfigurationResult {
    var result: MetadataTableConfigurationResult = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3TablesDestinationResult")) {
                    result.s3_tables_destination_result = try deserializeS3TablesDestinationResult(allocator, reader);
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

pub fn deserializeMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Metrics {
    var result: Metrics = undefined;
    result.event_threshold = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventThreshold")) {
                    result.event_threshold = try deserializeReplicationTimeValue(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = MetricsStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeMetricsConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricsConfiguration {
    var result: MetricsConfiguration = undefined;
    result.filter = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    try reader.skipElement();
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeMultipartUpload(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MultipartUpload {
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
                    result.checksum_algorithm = ChecksumAlgorithm.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = ChecksumType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Initiated")) {
                    result.initiated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Initiator")) {
                    result.initiator = try deserializeInitiator(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = StorageClass.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadId")) {
                    result.upload_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeNoncurrentVersionExpiration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NoncurrentVersionExpiration {
    _ = allocator;
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

pub fn deserializeNoncurrentVersionTransition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NoncurrentVersionTransition {
    _ = allocator;
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
                    result.storage_class = TransitionStorageClass.fromWireName(try reader.readElementText());
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

pub fn deserializeNotificationConfigurationFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NotificationConfigurationFilter {
    var result: NotificationConfigurationFilter = undefined;
    result.key = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3Key")) {
                    result.key = try deserializeS3KeyFilter(allocator, reader);
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

pub fn deserializeObject(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Object {
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
                    result.checksum_algorithm = try deserializeChecksumAlgorithmList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = ChecksumType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RestoreStatus")) {
                    result.restore_status = try deserializeRestoreStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = ObjectStorageClass.fromWireName(try reader.readElementText());
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

pub fn deserializeObjectLockConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLockConfiguration {
    var result: ObjectLockConfiguration = undefined;
    result.object_lock_enabled = null;
    result.rule = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ObjectLockEnabled")) {
                    result.object_lock_enabled = ObjectLockEnabled.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rule = try deserializeObjectLockRule(allocator, reader);
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

pub fn deserializeObjectLockLegalHold(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLockLegalHold {
    _ = allocator;
    var result: ObjectLockLegalHold = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ObjectLockLegalHoldStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeObjectLockRetention(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLockRetention {
    _ = allocator;
    var result: ObjectLockRetention = undefined;
    result.mode = null;
    result.retain_until_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = ObjectLockRetentionMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RetainUntilDate")) {
                    result.retain_until_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeObjectLockRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLockRule {
    var result: ObjectLockRule = undefined;
    result.default_retention = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultRetention")) {
                    result.default_retention = try deserializeDefaultRetention(allocator, reader);
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

pub fn deserializeObjectPart(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectPart {
    var result: ObjectPart = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_md5 = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.checksum_sha512 = null;
    result.checksum_xxhash128 = null;
    result.checksum_xxhash3 = null;
    result.checksum_xxhash64 = null;
    result.part_number = null;
    result.size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumMD5")) {
                    result.checksum_md5 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA512")) {
                    result.checksum_sha512 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH128")) {
                    result.checksum_xxhash128 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH3")) {
                    result.checksum_xxhash3 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH64")) {
                    result.checksum_xxhash64 = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeObjectVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectVersion {
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
                    result.checksum_algorithm = try deserializeChecksumAlgorithmList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = ChecksumType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsLatest")) {
                    result.is_latest = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeOwner(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RestoreStatus")) {
                    result.restore_status = try deserializeRestoreStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = ObjectVersionStorageClass.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOwner(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Owner {
    var result: Owner = undefined;
    result.display_name = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOwnershipControls(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OwnershipControls {
    var result: OwnershipControls = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rules = try deserializeOwnershipControlsRules(allocator, reader, "member");
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

pub fn deserializeOwnershipControlsRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OwnershipControlsRule {
    _ = allocator;
    var result: OwnershipControlsRule = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ObjectOwnership")) {
                    result.object_ownership = ObjectOwnership.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializePart(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Part {
    var result: Part = undefined;
    result.checksum_crc32 = null;
    result.checksum_crc32_c = null;
    result.checksum_crc64_nvme = null;
    result.checksum_md5 = null;
    result.checksum_sha1 = null;
    result.checksum_sha256 = null;
    result.checksum_sha512 = null;
    result.checksum_xxhash128 = null;
    result.checksum_xxhash3 = null;
    result.checksum_xxhash64 = null;
    result.e_tag = null;
    result.last_modified = null;
    result.part_number = null;
    result.size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumCRC32")) {
                    result.checksum_crc32 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC32C")) {
                    result.checksum_crc32_c = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumCRC64NVME")) {
                    result.checksum_crc64_nvme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumMD5")) {
                    result.checksum_md5 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA1")) {
                    result.checksum_sha1 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA256")) {
                    result.checksum_sha256 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumSHA512")) {
                    result.checksum_sha512 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH128")) {
                    result.checksum_xxhash128 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH3")) {
                    result.checksum_xxhash3 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumXXHASH64")) {
                    result.checksum_xxhash64 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializePartitionedPrefix(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PartitionedPrefix {
    _ = allocator;
    var result: PartitionedPrefix = undefined;
    result.partition_date_source = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PartitionDateSource")) {
                    result.partition_date_source = PartitionDateSource.fromWireName(try reader.readElementText());
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

pub fn deserializePolicyStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyStatus {
    _ = allocator;
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

pub fn deserializePublicAccessBlockConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PublicAccessBlockConfiguration {
    _ = allocator;
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

pub fn deserializeQueueConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueueConfiguration {
    var result: QueueConfiguration = undefined;
    result.filter = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Event")) {
                    result.events = try deserializeEventList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeNotificationConfigurationFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Queue")) {
                    result.queue_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeRecordExpiration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RecordExpiration {
    _ = allocator;
    var result: RecordExpiration = undefined;
    result.days = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Days")) {
                    result.days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = ExpirationState.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeRedirect(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Redirect {
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
                    result.host_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpRedirectCode")) {
                    result.http_redirect_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = Protocol.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplaceKeyPrefixWith")) {
                    result.replace_key_prefix_with = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplaceKeyWith")) {
                    result.replace_key_with = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeRedirectAllRequestsTo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RedirectAllRequestsTo {
    var result: RedirectAllRequestsTo = undefined;
    result.protocol = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostName")) {
                    result.host_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = Protocol.fromWireName(try reader.readElementText());
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

pub fn deserializeReplicaModifications(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicaModifications {
    _ = allocator;
    var result: ReplicaModifications = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ReplicaModificationsStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeReplicationConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationConfiguration {
    var result: ReplicationConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rules = try deserializeReplicationRules(allocator, reader, "member");
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

pub fn deserializeReplicationRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationRule {
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
                    result.delete_marker_replication = try deserializeDeleteMarkerReplication(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeDestination(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ExistingObjectReplication")) {
                    result.existing_object_replication = try deserializeExistingObjectReplication(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeReplicationRuleFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceSelectionCriteria")) {
                    result.source_selection_criteria = try deserializeSourceSelectionCriteria(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ReplicationRuleStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeReplicationRuleAndOperator(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationRuleAndOperator {
    var result: ReplicationRuleAndOperator = undefined;
    result.prefix = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tags = try deserializeTagSet(allocator, reader, "Tag");
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

pub fn deserializeReplicationRuleFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationRuleFilter {
    var result: ReplicationRuleFilter = undefined;
    result.@"and" = null;
    result.prefix = null;
    result.tag = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "And")) {
                    result.@"and" = try deserializeReplicationRuleAndOperator(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tag = try deserializeTag(allocator, reader);
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

pub fn deserializeReplicationTime(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationTime {
    var result: ReplicationTime = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ReplicationTimeStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Time")) {
                    result.time = try deserializeReplicationTimeValue(allocator, reader);
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

pub fn deserializeReplicationTimeValue(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationTimeValue {
    _ = allocator;
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

pub fn deserializeRestoreStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RestoreStatus {
    _ = allocator;
    var result: RestoreStatus = undefined;
    result.is_restore_in_progress = null;
    result.restore_expiry_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsRestoreInProgress")) {
                    result.is_restore_in_progress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RestoreExpiryDate")) {
                    result.restore_expiry_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeRoutingRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RoutingRule {
    var result: RoutingRule = undefined;
    result.condition = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Condition")) {
                    result.condition = try deserializeCondition(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Redirect")) {
                    result.redirect = try deserializeRedirect(allocator, reader);
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

pub fn deserializeS3KeyFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3KeyFilter {
    var result: S3KeyFilter = undefined;
    result.filter_rules = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FilterRule")) {
                    result.filter_rules = try deserializeFilterRuleList(allocator, reader, "member");
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

pub fn deserializeS3TablesDestinationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3TablesDestinationResult {
    var result: S3TablesDestinationResult = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TableArn")) {
                    result.table_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableBucketArn")) {
                    result.table_bucket_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableName")) {
                    result.table_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableNamespace")) {
                    result.table_namespace = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSSEKMS(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SSEKMS {
    var result: SSEKMS = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyId")) {
                    result.key_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSSES3(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SSES3 {
    _ = allocator;
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

pub fn deserializeServerSideEncryptionByDefault(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerSideEncryptionByDefault {
    var result: ServerSideEncryptionByDefault = undefined;
    result.kms_master_key_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KMSMasterKeyID")) {
                    result.kms_master_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSEAlgorithm")) {
                    result.sse_algorithm = ServerSideEncryption.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeServerSideEncryptionConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerSideEncryptionConfiguration {
    var result: ServerSideEncryptionConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rules = try deserializeServerSideEncryptionRules(allocator, reader, "member");
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

pub fn deserializeServerSideEncryptionRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerSideEncryptionRule {
    var result: ServerSideEncryptionRule = undefined;
    result.apply_server_side_encryption_by_default = null;
    result.blocked_encryption_types = null;
    result.bucket_key_enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplyServerSideEncryptionByDefault")) {
                    result.apply_server_side_encryption_by_default = try deserializeServerSideEncryptionByDefault(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "BlockedEncryptionTypes")) {
                    result.blocked_encryption_types = try deserializeBlockedEncryptionTypes(allocator, reader);
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

pub fn deserializeSessionCredentials(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SessionCredentials {
    var result: SessionCredentials = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretAccessKey")) {
                    result.secret_access_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionToken")) {
                    result.session_token = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSimplePrefix(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SimplePrefix {
    _ = allocator;
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

pub fn deserializeSourceSelectionCriteria(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SourceSelectionCriteria {
    var result: SourceSelectionCriteria = undefined;
    result.replica_modifications = null;
    result.sse_kms_encrypted_objects = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReplicaModifications")) {
                    result.replica_modifications = try deserializeReplicaModifications(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SseKmsEncryptedObjects")) {
                    result.sse_kms_encrypted_objects = try deserializeSseKmsEncryptedObjects(allocator, reader);
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

pub fn deserializeSseKmsEncryptedObjects(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SseKmsEncryptedObjects {
    _ = allocator;
    var result: SseKmsEncryptedObjects = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = SseKmsEncryptedObjectsStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeStorageClassAnalysis(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageClassAnalysis {
    var result: StorageClassAnalysis = undefined;
    result.data_export = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DataExport")) {
                    result.data_export = try deserializeStorageClassAnalysisDataExport(allocator, reader);
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

pub fn deserializeStorageClassAnalysisDataExport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageClassAnalysisDataExport {
    var result: StorageClassAnalysisDataExport = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeAnalyticsExportDestination(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "OutputSchemaVersion")) {
                    result.output_schema_version = StorageClassAnalysisSchemaVersion.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tag {
    var result: Tag = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTargetGrant(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetGrant {
    var result: TargetGrant = undefined;
    result.grantee = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeGrantee(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = BucketLogsPermission.fromWireName(try reader.readElementText());
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

pub fn deserializeTargetObjectKeyFormat(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetObjectKeyFormat {
    var result: TargetObjectKeyFormat = undefined;
    result.partitioned_prefix = null;
    result.simple_prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PartitionedPrefix")) {
                    result.partitioned_prefix = try deserializePartitionedPrefix(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SimplePrefix")) {
                    result.simple_prefix = try deserializeSimplePrefix(allocator, reader);
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

pub fn deserializeTiering(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tiering {
    _ = allocator;
    var result: Tiering = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessTier")) {
                    result.access_tier = IntelligentTieringAccessTier.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeTopicConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TopicConfiguration {
    var result: TopicConfiguration = undefined;
    result.filter = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Event")) {
                    result.events = try deserializeEventList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeNotificationConfigurationFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Topic")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTransition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Transition {
    _ = allocator;
    var result: Transition = undefined;
    result.date = null;
    result.days = null;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Days")) {
                    result.days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = TransitionStorageClass.fromWireName(try reader.readElementText());
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

pub fn serializeAllowedHeaders(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAllowedMethods(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAllowedOrigins(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCORSRules(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CORSRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCORSRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCompletedPartList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CompletedPart, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCompletedPart(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEncryptionTypeList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EncryptionType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEventList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Event, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeExposeHeaders(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeFilterRuleList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const FilterRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeFilterRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeGrants(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Grant, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeGrant(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeInventoryOptionalFields(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const InventoryOptionalField, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLambdaFunctionConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LambdaFunctionConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeLambdaFunctionConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLifecycleRules(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LifecycleRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeLifecycleRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeNoncurrentVersionTransitionList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const NoncurrentVersionTransition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeNoncurrentVersionTransition(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeObjectAttributesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectAttributes, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeObjectIdentifierList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectIdentifier, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeObjectIdentifier(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOptionalObjectAttributesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OptionalObjectAttributes, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOwnershipControlsRules(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OwnershipControlsRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOwnershipControlsRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeQueueConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const QueueConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeQueueConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeReplicationRules(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ReplicationRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeReplicationRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRoutingRules(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RoutingRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRoutingRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeServerSideEncryptionRules(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ServerSideEncryptionRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeServerSideEncryptionRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagSet(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTargetGrants(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetGrant, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTargetGrant(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTieringList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tiering, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTiering(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTopicConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TopicConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTopicConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTransitionList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Transition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTransition(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeUserMetadata(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetadataEntry, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetadataEntry(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetadata(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAbacStatus(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AbacStatus) !void {
    if (value.status) |v| {
        try buf.appendSlice(allocator, "<Status>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Status>");
    }
}

pub fn serializeAbortIncompleteMultipartUpload(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AbortIncompleteMultipartUpload) !void {
    if (value.days_after_initiation) |v| {
        try buf.appendSlice(allocator, "<DaysAfterInitiation>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DaysAfterInitiation>");
    }
}

pub fn serializeAccelerateConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccelerateConfiguration) !void {
    if (value.status) |v| {
        try buf.appendSlice(allocator, "<Status>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Status>");
    }
}

pub fn serializeAccessControlPolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessControlPolicy) !void {
    if (value.grants) |v| {
        try buf.appendSlice(allocator, "<AccessControlList>");
        try serializeGrants(allocator, buf, v, "Grant");
        try buf.appendSlice(allocator, "</AccessControlList>");
    }
    if (value.owner) |v| {
        try buf.appendSlice(allocator, "<Owner>");
        try serializeOwner(allocator, buf, v);
        try buf.appendSlice(allocator, "</Owner>");
    }
}

pub fn serializeAccessControlTranslation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessControlTranslation) !void {
    try buf.appendSlice(allocator, "<Owner>");
    try buf.appendSlice(allocator, value.owner.wireName());
    try buf.appendSlice(allocator, "</Owner>");
}

pub fn serializeAnalyticsConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnalyticsConfiguration) !void {
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    try buf.appendSlice(allocator, "<StorageClassAnalysis>");
    try serializeStorageClassAnalysis(allocator, buf, value.storage_class_analysis);
    try buf.appendSlice(allocator, "</StorageClassAnalysis>");
}

pub fn serializeAnalyticsExportDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnalyticsExportDestination) !void {
    try buf.appendSlice(allocator, "<S3BucketDestination>");
    try serializeAnalyticsS3BucketDestination(allocator, buf, value.s3_bucket_destination);
    try buf.appendSlice(allocator, "</S3BucketDestination>");
}

pub fn serializeAnalyticsS3BucketDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnalyticsS3BucketDestination) !void {
    try buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket);
    try buf.appendSlice(allocator, "</Bucket>");
    if (value.bucket_account_id) |v| {
        try buf.appendSlice(allocator, "<BucketAccountId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</BucketAccountId>");
    }
    try buf.appendSlice(allocator, "<Format>");
    try buf.appendSlice(allocator, value.format.wireName());
    try buf.appendSlice(allocator, "</Format>");
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
}

pub fn serializeBlockedEncryptionTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BlockedEncryptionTypes) !void {
    if (value.encryption_type) |v| {
        try serializeEncryptionTypeList(allocator, buf, v, "EncryptionType");
    }
}

pub fn serializeBucketInfo(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BucketInfo) !void {
    if (value.data_redundancy) |v| {
        try buf.appendSlice(allocator, "<DataRedundancy>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</DataRedundancy>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Type>");
    }
}

pub fn serializeBucketLifecycleConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BucketLifecycleConfiguration) !void {
    try serializeLifecycleRules(allocator, buf, value.rules, "Rule");
}

pub fn serializeBucketLoggingStatus(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BucketLoggingStatus) !void {
    if (value.logging_enabled) |v| {
        try buf.appendSlice(allocator, "<LoggingEnabled>");
        try serializeLoggingEnabled(allocator, buf, v);
        try buf.appendSlice(allocator, "</LoggingEnabled>");
    }
}

pub fn serializeCORSConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CORSConfiguration) !void {
    try serializeCORSRules(allocator, buf, value.cors_rules, "CORSRule");
}

pub fn serializeCORSRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CORSRule) !void {
    if (value.allowed_headers) |v| {
        try serializeAllowedHeaders(allocator, buf, v, "AllowedHeader");
    }
    try serializeAllowedMethods(allocator, buf, value.allowed_methods, "AllowedMethod");
    try serializeAllowedOrigins(allocator, buf, value.allowed_origins, "AllowedOrigin");
    if (value.expose_headers) |v| {
        try serializeExposeHeaders(allocator, buf, v, "ExposeHeader");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<ID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ID>");
    }
    if (value.max_age_seconds) |v| {
        try buf.appendSlice(allocator, "<MaxAgeSeconds>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxAgeSeconds>");
    }
}

pub fn serializeCSVInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CSVInput) !void {
    if (value.allow_quoted_record_delimiter) |v| {
        try buf.appendSlice(allocator, "<AllowQuotedRecordDelimiter>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</AllowQuotedRecordDelimiter>");
    }
    if (value.comments) |v| {
        try buf.appendSlice(allocator, "<Comments>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comments>");
    }
    if (value.field_delimiter) |v| {
        try buf.appendSlice(allocator, "<FieldDelimiter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</FieldDelimiter>");
    }
    if (value.file_header_info) |v| {
        try buf.appendSlice(allocator, "<FileHeaderInfo>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</FileHeaderInfo>");
    }
    if (value.quote_character) |v| {
        try buf.appendSlice(allocator, "<QuoteCharacter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</QuoteCharacter>");
    }
    if (value.quote_escape_character) |v| {
        try buf.appendSlice(allocator, "<QuoteEscapeCharacter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</QuoteEscapeCharacter>");
    }
    if (value.record_delimiter) |v| {
        try buf.appendSlice(allocator, "<RecordDelimiter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RecordDelimiter>");
    }
}

pub fn serializeCSVOutput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CSVOutput) !void {
    if (value.field_delimiter) |v| {
        try buf.appendSlice(allocator, "<FieldDelimiter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</FieldDelimiter>");
    }
    if (value.quote_character) |v| {
        try buf.appendSlice(allocator, "<QuoteCharacter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</QuoteCharacter>");
    }
    if (value.quote_escape_character) |v| {
        try buf.appendSlice(allocator, "<QuoteEscapeCharacter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</QuoteEscapeCharacter>");
    }
    if (value.quote_fields) |v| {
        try buf.appendSlice(allocator, "<QuoteFields>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</QuoteFields>");
    }
    if (value.record_delimiter) |v| {
        try buf.appendSlice(allocator, "<RecordDelimiter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RecordDelimiter>");
    }
}

pub fn serializeCompletedMultipartUpload(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CompletedMultipartUpload) !void {
    if (value.parts) |v| {
        try serializeCompletedPartList(allocator, buf, v, "Part");
    }
}

pub fn serializeCompletedPart(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CompletedPart) !void {
    if (value.checksum_crc32) |v| {
        try buf.appendSlice(allocator, "<ChecksumCRC32>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumCRC32>");
    }
    if (value.checksum_crc32_c) |v| {
        try buf.appendSlice(allocator, "<ChecksumCRC32C>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumCRC32C>");
    }
    if (value.checksum_crc64_nvme) |v| {
        try buf.appendSlice(allocator, "<ChecksumCRC64NVME>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumCRC64NVME>");
    }
    if (value.checksum_md5) |v| {
        try buf.appendSlice(allocator, "<ChecksumMD5>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumMD5>");
    }
    if (value.checksum_sha1) |v| {
        try buf.appendSlice(allocator, "<ChecksumSHA1>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumSHA1>");
    }
    if (value.checksum_sha256) |v| {
        try buf.appendSlice(allocator, "<ChecksumSHA256>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumSHA256>");
    }
    if (value.checksum_sha512) |v| {
        try buf.appendSlice(allocator, "<ChecksumSHA512>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumSHA512>");
    }
    if (value.checksum_xxhash128) |v| {
        try buf.appendSlice(allocator, "<ChecksumXXHASH128>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumXXHASH128>");
    }
    if (value.checksum_xxhash3) |v| {
        try buf.appendSlice(allocator, "<ChecksumXXHASH3>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumXXHASH3>");
    }
    if (value.checksum_xxhash64) |v| {
        try buf.appendSlice(allocator, "<ChecksumXXHASH64>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ChecksumXXHASH64>");
    }
    if (value.e_tag) |v| {
        try buf.appendSlice(allocator, "<ETag>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ETag>");
    }
    if (value.part_number) |v| {
        try buf.appendSlice(allocator, "<PartNumber>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</PartNumber>");
    }
}

pub fn serializeCondition(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Condition) !void {
    if (value.http_error_code_returned_equals) |v| {
        try buf.appendSlice(allocator, "<HttpErrorCodeReturnedEquals>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</HttpErrorCodeReturnedEquals>");
    }
    if (value.key_prefix_equals) |v| {
        try buf.appendSlice(allocator, "<KeyPrefixEquals>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</KeyPrefixEquals>");
    }
}

pub fn serializeCreateBucketConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CreateBucketConfiguration) !void {
    if (value.bucket) |v| {
        try buf.appendSlice(allocator, "<Bucket>");
        try serializeBucketInfo(allocator, buf, v);
        try buf.appendSlice(allocator, "</Bucket>");
    }
    if (value.location) |v| {
        try buf.appendSlice(allocator, "<Location>");
        try serializeLocationInfo(allocator, buf, v);
        try buf.appendSlice(allocator, "</Location>");
    }
    if (value.location_constraint) |v| {
        try buf.appendSlice(allocator, "<LocationConstraint>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</LocationConstraint>");
    }
    if (value.tags) |v| {
        try buf.appendSlice(allocator, "<Tags>");
        try serializeTagSet(allocator, buf, v, "Tag");
        try buf.appendSlice(allocator, "</Tags>");
    }
}

pub fn serializeDefaultRetention(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DefaultRetention) !void {
    if (value.days) |v| {
        try buf.appendSlice(allocator, "<Days>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Days>");
    }
    if (value.mode) |v| {
        try buf.appendSlice(allocator, "<Mode>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Mode>");
    }
    if (value.years) |v| {
        try buf.appendSlice(allocator, "<Years>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Years>");
    }
}

pub fn serializeDelete(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Delete) !void {
    try serializeObjectIdentifierList(allocator, buf, value.objects, "Object");
    if (value.quiet) |v| {
        try buf.appendSlice(allocator, "<Quiet>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Quiet>");
    }
}

pub fn serializeDeleteMarkerReplication(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeleteMarkerReplication) !void {
    if (value.status) |v| {
        try buf.appendSlice(allocator, "<Status>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Status>");
    }
}

pub fn serializeDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Destination) !void {
    if (value.access_control_translation) |v| {
        try buf.appendSlice(allocator, "<AccessControlTranslation>");
        try serializeAccessControlTranslation(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccessControlTranslation>");
    }
    if (value.account) |v| {
        try buf.appendSlice(allocator, "<Account>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Account>");
    }
    try buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket);
    try buf.appendSlice(allocator, "</Bucket>");
    if (value.encryption_configuration) |v| {
        try buf.appendSlice(allocator, "<EncryptionConfiguration>");
        try serializeEncryptionConfiguration(allocator, buf, v);
        try buf.appendSlice(allocator, "</EncryptionConfiguration>");
    }
    if (value.metrics) |v| {
        try buf.appendSlice(allocator, "<Metrics>");
        try serializeMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</Metrics>");
    }
    if (value.replication_time) |v| {
        try buf.appendSlice(allocator, "<ReplicationTime>");
        try serializeReplicationTime(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReplicationTime>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(allocator, "<StorageClass>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</StorageClass>");
    }
}

pub fn serializeEncryption(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Encryption) !void {
    try buf.appendSlice(allocator, "<EncryptionType>");
    try buf.appendSlice(allocator, value.encryption_type.wireName());
    try buf.appendSlice(allocator, "</EncryptionType>");
    if (value.kms_context) |v| {
        try buf.appendSlice(allocator, "<KMSContext>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</KMSContext>");
    }
    if (value.kms_key_id) |v| {
        try buf.appendSlice(allocator, "<KMSKeyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</KMSKeyId>");
    }
}

pub fn serializeEncryptionConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EncryptionConfiguration) !void {
    if (value.replica_kms_key_id) |v| {
        try buf.appendSlice(allocator, "<ReplicaKmsKeyID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReplicaKmsKeyID>");
    }
}

pub fn serializeErrorDocument(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ErrorDocument) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
}

pub fn serializeEventBridgeConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EventBridgeConfiguration) !void {
    _ = allocator;
    _ = buf;
    _ = value;
}

pub fn serializeExistingObjectReplication(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ExistingObjectReplication) !void {
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeFilterRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FilterRule) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeGlacierJobParameters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: GlacierJobParameters) !void {
    try buf.appendSlice(allocator, "<Tier>");
    try buf.appendSlice(allocator, value.tier.wireName());
    try buf.appendSlice(allocator, "</Tier>");
}

pub fn serializeGrant(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Grant) !void {
    if (value.grantee) |v| {
        try buf.appendSlice(allocator, "<Grantee>");
        try serializeGrantee(allocator, buf, v);
        try buf.appendSlice(allocator, "</Grantee>");
    }
    if (value.permission) |v| {
        try buf.appendSlice(allocator, "<Permission>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Permission>");
    }
}

pub fn serializeGrantee(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Grantee) !void {
    if (value.display_name) |v| {
        try buf.appendSlice(allocator, "<DisplayName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DisplayName>");
    }
    if (value.email_address) |v| {
        try buf.appendSlice(allocator, "<EmailAddress>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</EmailAddress>");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<ID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ID>");
    }
    try buf.appendSlice(allocator, "<xsi:type>");
    try buf.appendSlice(allocator, value.@"type".wireName());
    try buf.appendSlice(allocator, "</xsi:type>");
    if (value.uri) |v| {
        try buf.appendSlice(allocator, "<URI>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</URI>");
    }
}

pub fn serializeIndexDocument(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IndexDocument) !void {
    try buf.appendSlice(allocator, "<Suffix>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.suffix);
    try buf.appendSlice(allocator, "</Suffix>");
}

pub fn serializeInputSerialization(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InputSerialization) !void {
    if (value.compression_type) |v| {
        try buf.appendSlice(allocator, "<CompressionType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</CompressionType>");
    }
    if (value.csv) |v| {
        try buf.appendSlice(allocator, "<CSV>");
        try serializeCSVInput(allocator, buf, v);
        try buf.appendSlice(allocator, "</CSV>");
    }
    if (value.json) |v| {
        try buf.appendSlice(allocator, "<JSON>");
        try serializeJSONInput(allocator, buf, v);
        try buf.appendSlice(allocator, "</JSON>");
    }
    if (value.parquet) |v| {
        try buf.appendSlice(allocator, "<Parquet>");
        try serializeParquetInput(allocator, buf, v);
        try buf.appendSlice(allocator, "</Parquet>");
    }
}

pub fn serializeIntelligentTieringAndOperator(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IntelligentTieringAndOperator) !void {
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.tags) |v| {
        try serializeTagSet(allocator, buf, v, "Tag");
    }
}

pub fn serializeIntelligentTieringConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IntelligentTieringConfiguration) !void {
    if (value.filter) |v| {
        try buf.appendSlice(allocator, "<Filter>");
        try serializeIntelligentTieringFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</Filter>");
    }
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
    try serializeTieringList(allocator, buf, value.tierings, "Tiering");
}

pub fn serializeIntelligentTieringFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IntelligentTieringFilter) !void {
    if (value.@"and") |v| {
        try buf.appendSlice(allocator, "<And>");
        try serializeIntelligentTieringAndOperator(allocator, buf, v);
        try buf.appendSlice(allocator, "</And>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.tag) |v| {
        try buf.appendSlice(allocator, "<Tag>");
        try serializeTag(allocator, buf, v);
        try buf.appendSlice(allocator, "</Tag>");
    }
}

pub fn serializeInventoryConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventoryConfiguration) !void {
    try buf.appendSlice(allocator, "<Destination>");
    try serializeInventoryDestination(allocator, buf, value.destination);
    try buf.appendSlice(allocator, "</Destination>");
    if (value.filter) |v| {
        try buf.appendSlice(allocator, "<Filter>");
        try serializeInventoryFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</Filter>");
    }
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    try buf.appendSlice(allocator, "<IncludedObjectVersions>");
    try buf.appendSlice(allocator, value.included_object_versions.wireName());
    try buf.appendSlice(allocator, "</IncludedObjectVersions>");
    try buf.appendSlice(allocator, "<IsEnabled>");
    try buf.appendSlice(allocator, if (value.is_enabled) "true" else "false");
    try buf.appendSlice(allocator, "</IsEnabled>");
    if (value.optional_fields) |v| {
        try buf.appendSlice(allocator, "<OptionalFields>");
        try serializeInventoryOptionalFields(allocator, buf, v, "Field");
        try buf.appendSlice(allocator, "</OptionalFields>");
    }
    try buf.appendSlice(allocator, "<Schedule>");
    try serializeInventorySchedule(allocator, buf, value.schedule);
    try buf.appendSlice(allocator, "</Schedule>");
}

pub fn serializeInventoryDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventoryDestination) !void {
    try buf.appendSlice(allocator, "<S3BucketDestination>");
    try serializeInventoryS3BucketDestination(allocator, buf, value.s3_bucket_destination);
    try buf.appendSlice(allocator, "</S3BucketDestination>");
}

pub fn serializeInventoryEncryption(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventoryEncryption) !void {
    if (value.ssekms) |v| {
        try buf.appendSlice(allocator, "<SSE-KMS>");
        try serializeSSEKMS(allocator, buf, v);
        try buf.appendSlice(allocator, "</SSE-KMS>");
    }
    if (value.sses3) |v| {
        try buf.appendSlice(allocator, "<SSE-S3>");
        try serializeSSES3(allocator, buf, v);
        try buf.appendSlice(allocator, "</SSE-S3>");
    }
}

pub fn serializeInventoryFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventoryFilter) !void {
    try buf.appendSlice(allocator, "<Prefix>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.prefix);
    try buf.appendSlice(allocator, "</Prefix>");
}

pub fn serializeInventoryS3BucketDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventoryS3BucketDestination) !void {
    if (value.account_id) |v| {
        try buf.appendSlice(allocator, "<AccountId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccountId>");
    }
    try buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket);
    try buf.appendSlice(allocator, "</Bucket>");
    if (value.encryption) |v| {
        try buf.appendSlice(allocator, "<Encryption>");
        try serializeInventoryEncryption(allocator, buf, v);
        try buf.appendSlice(allocator, "</Encryption>");
    }
    try buf.appendSlice(allocator, "<Format>");
    try buf.appendSlice(allocator, value.format.wireName());
    try buf.appendSlice(allocator, "</Format>");
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
}

pub fn serializeInventorySchedule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventorySchedule) !void {
    try buf.appendSlice(allocator, "<Frequency>");
    try buf.appendSlice(allocator, value.frequency.wireName());
    try buf.appendSlice(allocator, "</Frequency>");
}

pub fn serializeInventoryTableConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventoryTableConfiguration) !void {
    try buf.appendSlice(allocator, "<ConfigurationState>");
    try buf.appendSlice(allocator, value.configuration_state.wireName());
    try buf.appendSlice(allocator, "</ConfigurationState>");
    if (value.encryption_configuration) |v| {
        try buf.appendSlice(allocator, "<EncryptionConfiguration>");
        try serializeMetadataTableEncryptionConfiguration(allocator, buf, v);
        try buf.appendSlice(allocator, "</EncryptionConfiguration>");
    }
}

pub fn serializeInventoryTableConfigurationUpdates(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InventoryTableConfigurationUpdates) !void {
    try buf.appendSlice(allocator, "<ConfigurationState>");
    try buf.appendSlice(allocator, value.configuration_state.wireName());
    try buf.appendSlice(allocator, "</ConfigurationState>");
    if (value.encryption_configuration) |v| {
        try buf.appendSlice(allocator, "<EncryptionConfiguration>");
        try serializeMetadataTableEncryptionConfiguration(allocator, buf, v);
        try buf.appendSlice(allocator, "</EncryptionConfiguration>");
    }
}

pub fn serializeJSONInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JSONInput) !void {
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Type>");
    }
}

pub fn serializeJSONOutput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JSONOutput) !void {
    if (value.record_delimiter) |v| {
        try buf.appendSlice(allocator, "<RecordDelimiter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RecordDelimiter>");
    }
}

pub fn serializeJournalTableConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JournalTableConfiguration) !void {
    if (value.encryption_configuration) |v| {
        try buf.appendSlice(allocator, "<EncryptionConfiguration>");
        try serializeMetadataTableEncryptionConfiguration(allocator, buf, v);
        try buf.appendSlice(allocator, "</EncryptionConfiguration>");
    }
    try buf.appendSlice(allocator, "<RecordExpiration>");
    try serializeRecordExpiration(allocator, buf, value.record_expiration);
    try buf.appendSlice(allocator, "</RecordExpiration>");
}

pub fn serializeJournalTableConfigurationUpdates(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JournalTableConfigurationUpdates) !void {
    try buf.appendSlice(allocator, "<RecordExpiration>");
    try serializeRecordExpiration(allocator, buf, value.record_expiration);
    try buf.appendSlice(allocator, "</RecordExpiration>");
}

pub fn serializeLambdaFunctionConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaFunctionConfiguration) !void {
    try serializeEventList(allocator, buf, value.events, "Event");
    if (value.filter) |v| {
        try buf.appendSlice(allocator, "<Filter>");
        try serializeNotificationConfigurationFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</Filter>");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<Id>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Id>");
    }
    try buf.appendSlice(allocator, "<CloudFunction>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.lambda_function_arn);
    try buf.appendSlice(allocator, "</CloudFunction>");
}

pub fn serializeLifecycleExpiration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleExpiration) !void {
    if (value.date) |v| {
        try buf.appendSlice(allocator, "<Date>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</Date>");
    }
    if (value.days) |v| {
        try buf.appendSlice(allocator, "<Days>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Days>");
    }
    if (value.expired_object_delete_marker) |v| {
        try buf.appendSlice(allocator, "<ExpiredObjectDeleteMarker>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ExpiredObjectDeleteMarker>");
    }
}

pub fn serializeLifecycleRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleRule) !void {
    if (value.abort_incomplete_multipart_upload) |v| {
        try buf.appendSlice(allocator, "<AbortIncompleteMultipartUpload>");
        try serializeAbortIncompleteMultipartUpload(allocator, buf, v);
        try buf.appendSlice(allocator, "</AbortIncompleteMultipartUpload>");
    }
    if (value.expiration) |v| {
        try buf.appendSlice(allocator, "<Expiration>");
        try serializeLifecycleExpiration(allocator, buf, v);
        try buf.appendSlice(allocator, "</Expiration>");
    }
    if (value.filter) |v| {
        try buf.appendSlice(allocator, "<Filter>");
        try serializeLifecycleRuleFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</Filter>");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<ID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ID>");
    }
    if (value.noncurrent_version_expiration) |v| {
        try buf.appendSlice(allocator, "<NoncurrentVersionExpiration>");
        try serializeNoncurrentVersionExpiration(allocator, buf, v);
        try buf.appendSlice(allocator, "</NoncurrentVersionExpiration>");
    }
    if (value.noncurrent_version_transitions) |v| {
        try serializeNoncurrentVersionTransitionList(allocator, buf, v, "NoncurrentVersionTransition");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
    if (value.transitions) |v| {
        try serializeTransitionList(allocator, buf, v, "Transition");
    }
}

pub fn serializeLifecycleRuleAndOperator(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleRuleAndOperator) !void {
    if (value.object_size_greater_than) |v| {
        try buf.appendSlice(allocator, "<ObjectSizeGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ObjectSizeGreaterThan>");
    }
    if (value.object_size_less_than) |v| {
        try buf.appendSlice(allocator, "<ObjectSizeLessThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ObjectSizeLessThan>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.tags) |v| {
        try serializeTagSet(allocator, buf, v, "Tag");
    }
}

pub fn serializeLifecycleRuleFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleRuleFilter) !void {
    if (value.@"and") |v| {
        try buf.appendSlice(allocator, "<And>");
        try serializeLifecycleRuleAndOperator(allocator, buf, v);
        try buf.appendSlice(allocator, "</And>");
    }
    if (value.object_size_greater_than) |v| {
        try buf.appendSlice(allocator, "<ObjectSizeGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ObjectSizeGreaterThan>");
    }
    if (value.object_size_less_than) |v| {
        try buf.appendSlice(allocator, "<ObjectSizeLessThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ObjectSizeLessThan>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.tag) |v| {
        try buf.appendSlice(allocator, "<Tag>");
        try serializeTag(allocator, buf, v);
        try buf.appendSlice(allocator, "</Tag>");
    }
}

pub fn serializeLocationInfo(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LocationInfo) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Type>");
    }
}

pub fn serializeLoggingEnabled(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoggingEnabled) !void {
    try buf.appendSlice(allocator, "<TargetBucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.target_bucket);
    try buf.appendSlice(allocator, "</TargetBucket>");
    if (value.target_grants) |v| {
        try buf.appendSlice(allocator, "<TargetGrants>");
        try serializeTargetGrants(allocator, buf, v, "Grant");
        try buf.appendSlice(allocator, "</TargetGrants>");
    }
    if (value.target_object_key_format) |v| {
        try buf.appendSlice(allocator, "<TargetObjectKeyFormat>");
        try serializeTargetObjectKeyFormat(allocator, buf, v);
        try buf.appendSlice(allocator, "</TargetObjectKeyFormat>");
    }
    try buf.appendSlice(allocator, "<TargetPrefix>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.target_prefix);
    try buf.appendSlice(allocator, "</TargetPrefix>");
}

pub fn serializeMetadataConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetadataConfiguration) !void {
    if (value.inventory_table_configuration) |v| {
        try buf.appendSlice(allocator, "<InventoryTableConfiguration>");
        try serializeInventoryTableConfiguration(allocator, buf, v);
        try buf.appendSlice(allocator, "</InventoryTableConfiguration>");
    }
    try buf.appendSlice(allocator, "<JournalTableConfiguration>");
    try serializeJournalTableConfiguration(allocator, buf, value.journal_table_configuration);
    try buf.appendSlice(allocator, "</JournalTableConfiguration>");
}

pub fn serializeMetadataEntry(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetadataEntry) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeMetadataTableConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetadataTableConfiguration) !void {
    try buf.appendSlice(allocator, "<S3TablesDestination>");
    try serializeS3TablesDestination(allocator, buf, value.s3_tables_destination);
    try buf.appendSlice(allocator, "</S3TablesDestination>");
}

pub fn serializeMetadataTableEncryptionConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetadataTableEncryptionConfiguration) !void {
    if (value.kms_key_arn) |v| {
        try buf.appendSlice(allocator, "<KmsKeyArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</KmsKeyArn>");
    }
    try buf.appendSlice(allocator, "<SseAlgorithm>");
    try buf.appendSlice(allocator, value.sse_algorithm.wireName());
    try buf.appendSlice(allocator, "</SseAlgorithm>");
}

pub fn serializeMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Metrics) !void {
    if (value.event_threshold) |v| {
        try buf.appendSlice(allocator, "<EventThreshold>");
        try serializeReplicationTimeValue(allocator, buf, v);
        try buf.appendSlice(allocator, "</EventThreshold>");
    }
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeMetricsConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricsConfiguration) !void {
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
}

pub fn serializeNoncurrentVersionExpiration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NoncurrentVersionExpiration) !void {
    if (value.newer_noncurrent_versions) |v| {
        try buf.appendSlice(allocator, "<NewerNoncurrentVersions>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</NewerNoncurrentVersions>");
    }
    if (value.noncurrent_days) |v| {
        try buf.appendSlice(allocator, "<NoncurrentDays>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</NoncurrentDays>");
    }
}

pub fn serializeNoncurrentVersionTransition(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NoncurrentVersionTransition) !void {
    if (value.newer_noncurrent_versions) |v| {
        try buf.appendSlice(allocator, "<NewerNoncurrentVersions>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</NewerNoncurrentVersions>");
    }
    if (value.noncurrent_days) |v| {
        try buf.appendSlice(allocator, "<NoncurrentDays>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</NoncurrentDays>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(allocator, "<StorageClass>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</StorageClass>");
    }
}

pub fn serializeNotificationConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NotificationConfiguration) !void {
    if (value.event_bridge_configuration) |v| {
        try buf.appendSlice(allocator, "<EventBridgeConfiguration>");
        try serializeEventBridgeConfiguration(allocator, buf, v);
        try buf.appendSlice(allocator, "</EventBridgeConfiguration>");
    }
    if (value.lambda_function_configurations) |v| {
        try serializeLambdaFunctionConfigurationList(allocator, buf, v, "CloudFunctionConfiguration");
    }
    if (value.queue_configurations) |v| {
        try serializeQueueConfigurationList(allocator, buf, v, "QueueConfiguration");
    }
    if (value.topic_configurations) |v| {
        try serializeTopicConfigurationList(allocator, buf, v, "TopicConfiguration");
    }
}

pub fn serializeNotificationConfigurationFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NotificationConfigurationFilter) !void {
    if (value.key) |v| {
        try buf.appendSlice(allocator, "<S3Key>");
        try serializeS3KeyFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3Key>");
    }
}

pub fn serializeObjectIdentifier(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectIdentifier) !void {
    if (value.e_tag) |v| {
        try buf.appendSlice(allocator, "<ETag>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ETag>");
    }
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    if (value.last_modified_time) |v| {
        try buf.appendSlice(allocator, "<LastModifiedTime>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</LastModifiedTime>");
    }
    if (value.size) |v| {
        try buf.appendSlice(allocator, "<Size>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Size>");
    }
    if (value.version_id) |v| {
        try buf.appendSlice(allocator, "<VersionId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</VersionId>");
    }
}

pub fn serializeObjectLockConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLockConfiguration) !void {
    if (value.object_lock_enabled) |v| {
        try buf.appendSlice(allocator, "<ObjectLockEnabled>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ObjectLockEnabled>");
    }
    if (value.rule) |v| {
        try buf.appendSlice(allocator, "<Rule>");
        try serializeObjectLockRule(allocator, buf, v);
        try buf.appendSlice(allocator, "</Rule>");
    }
}

pub fn serializeObjectLockLegalHold(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLockLegalHold) !void {
    if (value.status) |v| {
        try buf.appendSlice(allocator, "<Status>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Status>");
    }
}

pub fn serializeObjectLockRetention(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLockRetention) !void {
    if (value.mode) |v| {
        try buf.appendSlice(allocator, "<Mode>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Mode>");
    }
    if (value.retain_until_date) |v| {
        try buf.appendSlice(allocator, "<RetainUntilDate>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</RetainUntilDate>");
    }
}

pub fn serializeObjectLockRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLockRule) !void {
    if (value.default_retention) |v| {
        try buf.appendSlice(allocator, "<DefaultRetention>");
        try serializeDefaultRetention(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultRetention>");
    }
}

pub fn serializeOutputLocation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OutputLocation) !void {
    if (value.s3) |v| {
        try buf.appendSlice(allocator, "<S3>");
        try serializeS3Location(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3>");
    }
}

pub fn serializeOutputSerialization(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OutputSerialization) !void {
    if (value.csv) |v| {
        try buf.appendSlice(allocator, "<CSV>");
        try serializeCSVOutput(allocator, buf, v);
        try buf.appendSlice(allocator, "</CSV>");
    }
    if (value.json) |v| {
        try buf.appendSlice(allocator, "<JSON>");
        try serializeJSONOutput(allocator, buf, v);
        try buf.appendSlice(allocator, "</JSON>");
    }
}

pub fn serializeOwner(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Owner) !void {
    if (value.display_name) |v| {
        try buf.appendSlice(allocator, "<DisplayName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DisplayName>");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<ID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ID>");
    }
}

pub fn serializeOwnershipControls(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OwnershipControls) !void {
    try serializeOwnershipControlsRules(allocator, buf, value.rules, "Rule");
}

pub fn serializeOwnershipControlsRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OwnershipControlsRule) !void {
    try buf.appendSlice(allocator, "<ObjectOwnership>");
    try buf.appendSlice(allocator, value.object_ownership.wireName());
    try buf.appendSlice(allocator, "</ObjectOwnership>");
}

pub fn serializeParquetInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParquetInput) !void {
    _ = allocator;
    _ = buf;
    _ = value;
}

pub fn serializePartitionedPrefix(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PartitionedPrefix) !void {
    if (value.partition_date_source) |v| {
        try buf.appendSlice(allocator, "<PartitionDateSource>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</PartitionDateSource>");
    }
}

pub fn serializePublicAccessBlockConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PublicAccessBlockConfiguration) !void {
    if (value.block_public_acls) |v| {
        try buf.appendSlice(allocator, "<BlockPublicAcls>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</BlockPublicAcls>");
    }
    if (value.block_public_policy) |v| {
        try buf.appendSlice(allocator, "<BlockPublicPolicy>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</BlockPublicPolicy>");
    }
    if (value.ignore_public_acls) |v| {
        try buf.appendSlice(allocator, "<IgnorePublicAcls>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IgnorePublicAcls>");
    }
    if (value.restrict_public_buckets) |v| {
        try buf.appendSlice(allocator, "<RestrictPublicBuckets>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</RestrictPublicBuckets>");
    }
}

pub fn serializeQueueConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueueConfiguration) !void {
    try serializeEventList(allocator, buf, value.events, "Event");
    if (value.filter) |v| {
        try buf.appendSlice(allocator, "<Filter>");
        try serializeNotificationConfigurationFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</Filter>");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<Id>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Id>");
    }
    try buf.appendSlice(allocator, "<Queue>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.queue_arn);
    try buf.appendSlice(allocator, "</Queue>");
}

pub fn serializeRecordExpiration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RecordExpiration) !void {
    if (value.days) |v| {
        try buf.appendSlice(allocator, "<Days>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Days>");
    }
    try buf.appendSlice(allocator, "<Expiration>");
    try buf.appendSlice(allocator, value.expiration.wireName());
    try buf.appendSlice(allocator, "</Expiration>");
}

pub fn serializeRedirect(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Redirect) !void {
    if (value.host_name) |v| {
        try buf.appendSlice(allocator, "<HostName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</HostName>");
    }
    if (value.http_redirect_code) |v| {
        try buf.appendSlice(allocator, "<HttpRedirectCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</HttpRedirectCode>");
    }
    if (value.protocol) |v| {
        try buf.appendSlice(allocator, "<Protocol>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Protocol>");
    }
    if (value.replace_key_prefix_with) |v| {
        try buf.appendSlice(allocator, "<ReplaceKeyPrefixWith>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReplaceKeyPrefixWith>");
    }
    if (value.replace_key_with) |v| {
        try buf.appendSlice(allocator, "<ReplaceKeyWith>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReplaceKeyWith>");
    }
}

pub fn serializeRedirectAllRequestsTo(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RedirectAllRequestsTo) !void {
    try buf.appendSlice(allocator, "<HostName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.host_name);
    try buf.appendSlice(allocator, "</HostName>");
    if (value.protocol) |v| {
        try buf.appendSlice(allocator, "<Protocol>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Protocol>");
    }
}

pub fn serializeReplicaModifications(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicaModifications) !void {
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeReplicationConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationConfiguration) !void {
    try buf.appendSlice(allocator, "<Role>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.role);
    try buf.appendSlice(allocator, "</Role>");
    try serializeReplicationRules(allocator, buf, value.rules, "Rule");
}

pub fn serializeReplicationRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationRule) !void {
    if (value.delete_marker_replication) |v| {
        try buf.appendSlice(allocator, "<DeleteMarkerReplication>");
        try serializeDeleteMarkerReplication(allocator, buf, v);
        try buf.appendSlice(allocator, "</DeleteMarkerReplication>");
    }
    try buf.appendSlice(allocator, "<Destination>");
    try serializeDestination(allocator, buf, value.destination);
    try buf.appendSlice(allocator, "</Destination>");
    if (value.existing_object_replication) |v| {
        try buf.appendSlice(allocator, "<ExistingObjectReplication>");
        try serializeExistingObjectReplication(allocator, buf, v);
        try buf.appendSlice(allocator, "</ExistingObjectReplication>");
    }
    if (value.filter) |v| {
        try buf.appendSlice(allocator, "<Filter>");
        try serializeReplicationRuleFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</Filter>");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<ID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ID>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.priority) |v| {
        try buf.appendSlice(allocator, "<Priority>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Priority>");
    }
    if (value.source_selection_criteria) |v| {
        try buf.appendSlice(allocator, "<SourceSelectionCriteria>");
        try serializeSourceSelectionCriteria(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceSelectionCriteria>");
    }
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeReplicationRuleAndOperator(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationRuleAndOperator) !void {
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.tags) |v| {
        try serializeTagSet(allocator, buf, v, "Tag");
    }
}

pub fn serializeReplicationRuleFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationRuleFilter) !void {
    if (value.@"and") |v| {
        try buf.appendSlice(allocator, "<And>");
        try serializeReplicationRuleAndOperator(allocator, buf, v);
        try buf.appendSlice(allocator, "</And>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.tag) |v| {
        try buf.appendSlice(allocator, "<Tag>");
        try serializeTag(allocator, buf, v);
        try buf.appendSlice(allocator, "</Tag>");
    }
}

pub fn serializeReplicationTime(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationTime) !void {
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
    try buf.appendSlice(allocator, "<Time>");
    try serializeReplicationTimeValue(allocator, buf, value.time);
    try buf.appendSlice(allocator, "</Time>");
}

pub fn serializeReplicationTimeValue(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationTimeValue) !void {
    if (value.minutes) |v| {
        try buf.appendSlice(allocator, "<Minutes>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Minutes>");
    }
}

pub fn serializeRequestPaymentConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RequestPaymentConfiguration) !void {
    try buf.appendSlice(allocator, "<Payer>");
    try buf.appendSlice(allocator, value.payer.wireName());
    try buf.appendSlice(allocator, "</Payer>");
}

pub fn serializeRequestProgress(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RequestProgress) !void {
    if (value.enabled) |v| {
        try buf.appendSlice(allocator, "<Enabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Enabled>");
    }
}

pub fn serializeRestoreRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RestoreRequest) !void {
    if (value.days) |v| {
        try buf.appendSlice(allocator, "<Days>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Days>");
    }
    if (value.description) |v| {
        try buf.appendSlice(allocator, "<Description>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Description>");
    }
    if (value.glacier_job_parameters) |v| {
        try buf.appendSlice(allocator, "<GlacierJobParameters>");
        try serializeGlacierJobParameters(allocator, buf, v);
        try buf.appendSlice(allocator, "</GlacierJobParameters>");
    }
    if (value.output_location) |v| {
        try buf.appendSlice(allocator, "<OutputLocation>");
        try serializeOutputLocation(allocator, buf, v);
        try buf.appendSlice(allocator, "</OutputLocation>");
    }
    if (value.select_parameters) |v| {
        try buf.appendSlice(allocator, "<SelectParameters>");
        try serializeSelectParameters(allocator, buf, v);
        try buf.appendSlice(allocator, "</SelectParameters>");
    }
    if (value.tier) |v| {
        try buf.appendSlice(allocator, "<Tier>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Tier>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Type>");
    }
}

pub fn serializeRoutingRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RoutingRule) !void {
    if (value.condition) |v| {
        try buf.appendSlice(allocator, "<Condition>");
        try serializeCondition(allocator, buf, v);
        try buf.appendSlice(allocator, "</Condition>");
    }
    try buf.appendSlice(allocator, "<Redirect>");
    try serializeRedirect(allocator, buf, value.redirect);
    try buf.appendSlice(allocator, "</Redirect>");
}

pub fn serializeS3KeyFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3KeyFilter) !void {
    if (value.filter_rules) |v| {
        try serializeFilterRuleList(allocator, buf, v, "FilterRule");
    }
}

pub fn serializeS3Location(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Location) !void {
    if (value.access_control_list) |v| {
        try buf.appendSlice(allocator, "<AccessControlList>");
        try serializeGrants(allocator, buf, v, "Grant");
        try buf.appendSlice(allocator, "</AccessControlList>");
    }
    try buf.appendSlice(allocator, "<BucketName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket_name);
    try buf.appendSlice(allocator, "</BucketName>");
    if (value.canned_acl) |v| {
        try buf.appendSlice(allocator, "<CannedACL>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</CannedACL>");
    }
    if (value.encryption) |v| {
        try buf.appendSlice(allocator, "<Encryption>");
        try serializeEncryption(allocator, buf, v);
        try buf.appendSlice(allocator, "</Encryption>");
    }
    try buf.appendSlice(allocator, "<Prefix>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.prefix);
    try buf.appendSlice(allocator, "</Prefix>");
    if (value.storage_class) |v| {
        try buf.appendSlice(allocator, "<StorageClass>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</StorageClass>");
    }
    if (value.tagging) |v| {
        try buf.appendSlice(allocator, "<Tagging>");
        try serializeTagging(allocator, buf, v);
        try buf.appendSlice(allocator, "</Tagging>");
    }
    if (value.user_metadata) |v| {
        try buf.appendSlice(allocator, "<UserMetadata>");
        try serializeUserMetadata(allocator, buf, v, "MetadataEntry");
        try buf.appendSlice(allocator, "</UserMetadata>");
    }
}

pub fn serializeS3TablesDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3TablesDestination) !void {
    try buf.appendSlice(allocator, "<TableBucketArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.table_bucket_arn);
    try buf.appendSlice(allocator, "</TableBucketArn>");
    try buf.appendSlice(allocator, "<TableName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.table_name);
    try buf.appendSlice(allocator, "</TableName>");
}

pub fn serializeSSEKMS(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SSEKMS) !void {
    try buf.appendSlice(allocator, "<KeyId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key_id);
    try buf.appendSlice(allocator, "</KeyId>");
}

pub fn serializeSSES3(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SSES3) !void {
    _ = allocator;
    _ = buf;
    _ = value;
}

pub fn serializeScanRange(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScanRange) !void {
    if (value.end) |v| {
        try buf.appendSlice(allocator, "<End>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</End>");
    }
    if (value.start) |v| {
        try buf.appendSlice(allocator, "<Start>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Start>");
    }
}

pub fn serializeSelectParameters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SelectParameters) !void {
    try buf.appendSlice(allocator, "<Expression>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.expression);
    try buf.appendSlice(allocator, "</Expression>");
    try buf.appendSlice(allocator, "<ExpressionType>");
    try buf.appendSlice(allocator, value.expression_type.wireName());
    try buf.appendSlice(allocator, "</ExpressionType>");
    try buf.appendSlice(allocator, "<InputSerialization>");
    try serializeInputSerialization(allocator, buf, value.input_serialization);
    try buf.appendSlice(allocator, "</InputSerialization>");
    try buf.appendSlice(allocator, "<OutputSerialization>");
    try serializeOutputSerialization(allocator, buf, value.output_serialization);
    try buf.appendSlice(allocator, "</OutputSerialization>");
}

pub fn serializeServerSideEncryptionByDefault(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ServerSideEncryptionByDefault) !void {
    if (value.kms_master_key_id) |v| {
        try buf.appendSlice(allocator, "<KMSMasterKeyID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</KMSMasterKeyID>");
    }
    try buf.appendSlice(allocator, "<SSEAlgorithm>");
    try buf.appendSlice(allocator, value.sse_algorithm.wireName());
    try buf.appendSlice(allocator, "</SSEAlgorithm>");
}

pub fn serializeServerSideEncryptionConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ServerSideEncryptionConfiguration) !void {
    try serializeServerSideEncryptionRules(allocator, buf, value.rules, "Rule");
}

pub fn serializeServerSideEncryptionRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ServerSideEncryptionRule) !void {
    if (value.apply_server_side_encryption_by_default) |v| {
        try buf.appendSlice(allocator, "<ApplyServerSideEncryptionByDefault>");
        try serializeServerSideEncryptionByDefault(allocator, buf, v);
        try buf.appendSlice(allocator, "</ApplyServerSideEncryptionByDefault>");
    }
    if (value.blocked_encryption_types) |v| {
        try buf.appendSlice(allocator, "<BlockedEncryptionTypes>");
        try serializeBlockedEncryptionTypes(allocator, buf, v);
        try buf.appendSlice(allocator, "</BlockedEncryptionTypes>");
    }
    if (value.bucket_key_enabled) |v| {
        try buf.appendSlice(allocator, "<BucketKeyEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</BucketKeyEnabled>");
    }
}

pub fn serializeSimplePrefix(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SimplePrefix) !void {
    _ = allocator;
    _ = buf;
    _ = value;
}

pub fn serializeSourceSelectionCriteria(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceSelectionCriteria) !void {
    if (value.replica_modifications) |v| {
        try buf.appendSlice(allocator, "<ReplicaModifications>");
        try serializeReplicaModifications(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReplicaModifications>");
    }
    if (value.sse_kms_encrypted_objects) |v| {
        try buf.appendSlice(allocator, "<SseKmsEncryptedObjects>");
        try serializeSseKmsEncryptedObjects(allocator, buf, v);
        try buf.appendSlice(allocator, "</SseKmsEncryptedObjects>");
    }
}

pub fn serializeSseKmsEncryptedObjects(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SseKmsEncryptedObjects) !void {
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeStorageClassAnalysis(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageClassAnalysis) !void {
    if (value.data_export) |v| {
        try buf.appendSlice(allocator, "<DataExport>");
        try serializeStorageClassAnalysisDataExport(allocator, buf, v);
        try buf.appendSlice(allocator, "</DataExport>");
    }
}

pub fn serializeStorageClassAnalysisDataExport(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageClassAnalysisDataExport) !void {
    try buf.appendSlice(allocator, "<Destination>");
    try serializeAnalyticsExportDestination(allocator, buf, value.destination);
    try buf.appendSlice(allocator, "</Destination>");
    try buf.appendSlice(allocator, "<OutputSchemaVersion>");
    try buf.appendSlice(allocator, value.output_schema_version.wireName());
    try buf.appendSlice(allocator, "</OutputSchemaVersion>");
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeTagging(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tagging) !void {
    try buf.appendSlice(allocator, "<TagSet>");
    try serializeTagSet(allocator, buf, value.tag_set, "Tag");
    try buf.appendSlice(allocator, "</TagSet>");
}

pub fn serializeTargetGrant(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetGrant) !void {
    if (value.grantee) |v| {
        try buf.appendSlice(allocator, "<Grantee>");
        try serializeGrantee(allocator, buf, v);
        try buf.appendSlice(allocator, "</Grantee>");
    }
    if (value.permission) |v| {
        try buf.appendSlice(allocator, "<Permission>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Permission>");
    }
}

pub fn serializeTargetObjectKeyFormat(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetObjectKeyFormat) !void {
    if (value.partitioned_prefix) |v| {
        try buf.appendSlice(allocator, "<PartitionedPrefix>");
        try serializePartitionedPrefix(allocator, buf, v);
        try buf.appendSlice(allocator, "</PartitionedPrefix>");
    }
    if (value.simple_prefix) |v| {
        try buf.appendSlice(allocator, "<SimplePrefix>");
        try serializeSimplePrefix(allocator, buf, v);
        try buf.appendSlice(allocator, "</SimplePrefix>");
    }
}

pub fn serializeTiering(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tiering) !void {
    try buf.appendSlice(allocator, "<AccessTier>");
    try buf.appendSlice(allocator, value.access_tier.wireName());
    try buf.appendSlice(allocator, "</AccessTier>");
    try buf.appendSlice(allocator, "<Days>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.days}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Days>");
}

pub fn serializeTopicConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TopicConfiguration) !void {
    try serializeEventList(allocator, buf, value.events, "Event");
    if (value.filter) |v| {
        try buf.appendSlice(allocator, "<Filter>");
        try serializeNotificationConfigurationFilter(allocator, buf, v);
        try buf.appendSlice(allocator, "</Filter>");
    }
    if (value.id) |v| {
        try buf.appendSlice(allocator, "<Id>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Id>");
    }
    try buf.appendSlice(allocator, "<Topic>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.topic_arn);
    try buf.appendSlice(allocator, "</Topic>");
}

pub fn serializeTransition(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Transition) !void {
    if (value.date) |v| {
        try buf.appendSlice(allocator, "<Date>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</Date>");
    }
    if (value.days) |v| {
        try buf.appendSlice(allocator, "<Days>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Days>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(allocator, "<StorageClass>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</StorageClass>");
    }
}

pub fn serializeVersioningConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: VersioningConfiguration) !void {
    if (value.mfa_delete) |v| {
        try buf.appendSlice(allocator, "<MfaDelete>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</MfaDelete>");
    }
    if (value.status) |v| {
        try buf.appendSlice(allocator, "<Status>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Status>");
    }
}

pub fn serializeWebsiteConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: WebsiteConfiguration) !void {
    if (value.error_document) |v| {
        try buf.appendSlice(allocator, "<ErrorDocument>");
        try serializeErrorDocument(allocator, buf, v);
        try buf.appendSlice(allocator, "</ErrorDocument>");
    }
    if (value.index_document) |v| {
        try buf.appendSlice(allocator, "<IndexDocument>");
        try serializeIndexDocument(allocator, buf, v);
        try buf.appendSlice(allocator, "</IndexDocument>");
    }
    if (value.redirect_all_requests_to) |v| {
        try buf.appendSlice(allocator, "<RedirectAllRequestsTo>");
        try serializeRedirectAllRequestsTo(allocator, buf, v);
        try buf.appendSlice(allocator, "</RedirectAllRequestsTo>");
    }
    if (value.routing_rules) |v| {
        try buf.appendSlice(allocator, "<RoutingRules>");
        try serializeRoutingRules(allocator, buf, v, "RoutingRule");
        try buf.appendSlice(allocator, "</RoutingRules>");
    }
}

