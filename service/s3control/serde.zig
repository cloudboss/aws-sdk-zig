const aws = @import("aws");
const std = @import("std");

const AbortIncompleteMultipartUpload = @import("abort_incomplete_multipart_upload.zig").AbortIncompleteMultipartUpload;
const AccessControlTranslation = @import("access_control_translation.zig").AccessControlTranslation;
const AccessGrantsLocationConfiguration = @import("access_grants_location_configuration.zig").AccessGrantsLocationConfiguration;
const AccessPoint = @import("access_point.zig").AccessPoint;
const AccountLevel = @import("account_level.zig").AccountLevel;
const ActivityMetrics = @import("activity_metrics.zig").ActivityMetrics;
const AdvancedCostOptimizationMetrics = @import("advanced_cost_optimization_metrics.zig").AdvancedCostOptimizationMetrics;
const AdvancedDataProtectionMetrics = @import("advanced_data_protection_metrics.zig").AdvancedDataProtectionMetrics;
const AdvancedPerformanceMetrics = @import("advanced_performance_metrics.zig").AdvancedPerformanceMetrics;
const AsyncErrorDetails = @import("async_error_details.zig").AsyncErrorDetails;
const AsyncOperation = @import("async_operation.zig").AsyncOperation;
const AsyncOperationName = @import("async_operation_name.zig").AsyncOperationName;
const AsyncRequestParameters = @import("async_request_parameters.zig").AsyncRequestParameters;
const AsyncResponseDetails = @import("async_response_details.zig").AsyncResponseDetails;
const BucketLevel = @import("bucket_level.zig").BucketLevel;
const BucketLocationConstraint = @import("bucket_location_constraint.zig").BucketLocationConstraint;
const BucketVersioningStatus = @import("bucket_versioning_status.zig").BucketVersioningStatus;
const CloudWatchMetrics = @import("cloud_watch_metrics.zig").CloudWatchMetrics;
const ComputeObjectChecksumAlgorithm = @import("compute_object_checksum_algorithm.zig").ComputeObjectChecksumAlgorithm;
const ComputeObjectChecksumType = @import("compute_object_checksum_type.zig").ComputeObjectChecksumType;
const CreateBucketConfiguration = @import("create_bucket_configuration.zig").CreateBucketConfiguration;
const CreateMultiRegionAccessPointInput = @import("create_multi_region_access_point_input.zig").CreateMultiRegionAccessPointInput;
const Credentials = @import("credentials.zig").Credentials;
const DeleteMarkerReplication = @import("delete_marker_replication.zig").DeleteMarkerReplication;
const DeleteMarkerReplicationStatus = @import("delete_marker_replication_status.zig").DeleteMarkerReplicationStatus;
const DeleteMultiRegionAccessPointInput = @import("delete_multi_region_access_point_input.zig").DeleteMultiRegionAccessPointInput;
const Destination = @import("destination.zig").Destination;
const DetailedStatusCodesMetrics = @import("detailed_status_codes_metrics.zig").DetailedStatusCodesMetrics;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const EstablishedMultiRegionAccessPointPolicy = @import("established_multi_region_access_point_policy.zig").EstablishedMultiRegionAccessPointPolicy;
const Exclude = @import("exclude.zig").Exclude;
const ExistingObjectReplication = @import("existing_object_replication.zig").ExistingObjectReplication;
const ExistingObjectReplicationStatus = @import("existing_object_replication_status.zig").ExistingObjectReplicationStatus;
const ExpirationStatus = @import("expiration_status.zig").ExpirationStatus;
const Format = @import("format.zig").Format;
const GeneratedManifestFormat = @import("generated_manifest_format.zig").GeneratedManifestFormat;
const Grantee = @import("grantee.zig").Grantee;
const GranteeType = @import("grantee_type.zig").GranteeType;
const Include = @import("include.zig").Include;
const JobDescriptor = @import("job_descriptor.zig").JobDescriptor;
const JobFailure = @import("job_failure.zig").JobFailure;
const JobListDescriptor = @import("job_list_descriptor.zig").JobListDescriptor;
const JobManifest = @import("job_manifest.zig").JobManifest;
const JobManifestFieldName = @import("job_manifest_field_name.zig").JobManifestFieldName;
const JobManifestFormat = @import("job_manifest_format.zig").JobManifestFormat;
const JobManifestLocation = @import("job_manifest_location.zig").JobManifestLocation;
const JobManifestSpec = @import("job_manifest_spec.zig").JobManifestSpec;
const JobOperation = @import("job_operation.zig").JobOperation;
const JobProgressSummary = @import("job_progress_summary.zig").JobProgressSummary;
const JobReport = @import("job_report.zig").JobReport;
const JobReportFormat = @import("job_report_format.zig").JobReportFormat;
const JobReportScope = @import("job_report_scope.zig").JobReportScope;
const JobStatus = @import("job_status.zig").JobStatus;
const JobTimers = @import("job_timers.zig").JobTimers;
const LambdaInvokeOperation = @import("lambda_invoke_operation.zig").LambdaInvokeOperation;
const LifecycleConfiguration = @import("lifecycle_configuration.zig").LifecycleConfiguration;
const LifecycleExpiration = @import("lifecycle_expiration.zig").LifecycleExpiration;
const LifecycleRule = @import("lifecycle_rule.zig").LifecycleRule;
const LifecycleRuleAndOperator = @import("lifecycle_rule_and_operator.zig").LifecycleRuleAndOperator;
const LifecycleRuleFilter = @import("lifecycle_rule_filter.zig").LifecycleRuleFilter;
const ListAccessGrantEntry = @import("list_access_grant_entry.zig").ListAccessGrantEntry;
const ListAccessGrantsInstanceEntry = @import("list_access_grants_instance_entry.zig").ListAccessGrantsInstanceEntry;
const ListAccessGrantsLocationsEntry = @import("list_access_grants_locations_entry.zig").ListAccessGrantsLocationsEntry;
const ListCallerAccessGrantsEntry = @import("list_caller_access_grants_entry.zig").ListCallerAccessGrantsEntry;
const ListStorageLensConfigurationEntry = @import("list_storage_lens_configuration_entry.zig").ListStorageLensConfigurationEntry;
const ListStorageLensGroupEntry = @import("list_storage_lens_group_entry.zig").ListStorageLensGroupEntry;
const MFADelete = @import("mfa_delete.zig").MFADelete;
const MatchObjectAge = @import("match_object_age.zig").MatchObjectAge;
const MatchObjectSize = @import("match_object_size.zig").MatchObjectSize;
const Metrics = @import("metrics.zig").Metrics;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const MultiRegionAccessPointPolicyDocument = @import("multi_region_access_point_policy_document.zig").MultiRegionAccessPointPolicyDocument;
const MultiRegionAccessPointRegionalResponse = @import("multi_region_access_point_regional_response.zig").MultiRegionAccessPointRegionalResponse;
const MultiRegionAccessPointReport = @import("multi_region_access_point_report.zig").MultiRegionAccessPointReport;
const MultiRegionAccessPointRoute = @import("multi_region_access_point_route.zig").MultiRegionAccessPointRoute;
const MultiRegionAccessPointStatus = @import("multi_region_access_point_status.zig").MultiRegionAccessPointStatus;
const MultiRegionAccessPointsAsyncResponse = @import("multi_region_access_points_async_response.zig").MultiRegionAccessPointsAsyncResponse;
const NetworkOrigin = @import("network_origin.zig").NetworkOrigin;
const NoncurrentVersionExpiration = @import("noncurrent_version_expiration.zig").NoncurrentVersionExpiration;
const NoncurrentVersionTransition = @import("noncurrent_version_transition.zig").NoncurrentVersionTransition;
const ObjectEncryption = @import("object_encryption.zig").ObjectEncryption;
const ObjectLambdaAccessPoint = @import("object_lambda_access_point.zig").ObjectLambdaAccessPoint;
const ObjectLambdaAccessPointAlias = @import("object_lambda_access_point_alias.zig").ObjectLambdaAccessPointAlias;
const ObjectLambdaAccessPointAliasStatus = @import("object_lambda_access_point_alias_status.zig").ObjectLambdaAccessPointAliasStatus;
const ObjectLambdaAllowedFeature = @import("object_lambda_allowed_feature.zig").ObjectLambdaAllowedFeature;
const ObjectLambdaConfiguration = @import("object_lambda_configuration.zig").ObjectLambdaConfiguration;
const ObjectLambdaTransformationConfiguration = @import("object_lambda_transformation_configuration.zig").ObjectLambdaTransformationConfiguration;
const ObjectLambdaTransformationConfigurationAction = @import("object_lambda_transformation_configuration_action.zig").ObjectLambdaTransformationConfigurationAction;
const OperationName = @import("operation_name.zig").OperationName;
const OutputSchemaVersion = @import("output_schema_version.zig").OutputSchemaVersion;
const OwnerOverride = @import("owner_override.zig").OwnerOverride;
const Permission = @import("permission.zig").Permission;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;
const PrefixLevel = @import("prefix_level.zig").PrefixLevel;
const PrefixLevelStorageMetrics = @import("prefix_level_storage_metrics.zig").PrefixLevelStorageMetrics;
const ProposedMultiRegionAccessPointPolicy = @import("proposed_multi_region_access_point_policy.zig").ProposedMultiRegionAccessPointPolicy;
const PublicAccessBlockConfiguration = @import("public_access_block_configuration.zig").PublicAccessBlockConfiguration;
const PutMultiRegionAccessPointPolicyInput = @import("put_multi_region_access_point_policy_input.zig").PutMultiRegionAccessPointPolicyInput;
const Region = @import("region.zig").Region;
const RegionReport = @import("region_report.zig").RegionReport;
const RegionalBucket = @import("regional_bucket.zig").RegionalBucket;
const ReplicaModifications = @import("replica_modifications.zig").ReplicaModifications;
const ReplicaModificationsStatus = @import("replica_modifications_status.zig").ReplicaModificationsStatus;
const ReplicationConfiguration = @import("replication_configuration.zig").ReplicationConfiguration;
const ReplicationRule = @import("replication_rule.zig").ReplicationRule;
const ReplicationRuleAndOperator = @import("replication_rule_and_operator.zig").ReplicationRuleAndOperator;
const ReplicationRuleFilter = @import("replication_rule_filter.zig").ReplicationRuleFilter;
const ReplicationRuleStatus = @import("replication_rule_status.zig").ReplicationRuleStatus;
const ReplicationStorageClass = @import("replication_storage_class.zig").ReplicationStorageClass;
const ReplicationTime = @import("replication_time.zig").ReplicationTime;
const ReplicationTimeStatus = @import("replication_time_status.zig").ReplicationTimeStatus;
const ReplicationTimeValue = @import("replication_time_value.zig").ReplicationTimeValue;
const S3AccessControlList = @import("s3_access_control_list.zig").S3AccessControlList;
const S3AccessControlPolicy = @import("s3_access_control_policy.zig").S3AccessControlPolicy;
const S3BucketDestination = @import("s3_bucket_destination.zig").S3BucketDestination;
const S3CannedAccessControlList = @import("s3_canned_access_control_list.zig").S3CannedAccessControlList;
const S3ChecksumAlgorithm = @import("s3_checksum_algorithm.zig").S3ChecksumAlgorithm;
const S3ComputeObjectChecksumOperation = @import("s3_compute_object_checksum_operation.zig").S3ComputeObjectChecksumOperation;
const S3CopyObjectOperation = @import("s3_copy_object_operation.zig").S3CopyObjectOperation;
const S3DeleteObjectTaggingOperation = @import("s3_delete_object_tagging_operation.zig").S3DeleteObjectTaggingOperation;
const S3GeneratedManifestDescriptor = @import("s3_generated_manifest_descriptor.zig").S3GeneratedManifestDescriptor;
const S3GlacierJobTier = @import("s3_glacier_job_tier.zig").S3GlacierJobTier;
const S3Grant = @import("s3_grant.zig").S3Grant;
const S3Grantee = @import("s3_grantee.zig").S3Grantee;
const S3GranteeTypeIdentifier = @import("s3_grantee_type_identifier.zig").S3GranteeTypeIdentifier;
const S3InitiateRestoreObjectOperation = @import("s3_initiate_restore_object_operation.zig").S3InitiateRestoreObjectOperation;
const S3MetadataDirective = @import("s3_metadata_directive.zig").S3MetadataDirective;
const S3ObjectLockLegalHold = @import("s3_object_lock_legal_hold.zig").S3ObjectLockLegalHold;
const S3ObjectLockLegalHoldStatus = @import("s3_object_lock_legal_hold_status.zig").S3ObjectLockLegalHoldStatus;
const S3ObjectLockMode = @import("s3_object_lock_mode.zig").S3ObjectLockMode;
const S3ObjectLockRetentionMode = @import("s3_object_lock_retention_mode.zig").S3ObjectLockRetentionMode;
const S3ObjectMetadata = @import("s3_object_metadata.zig").S3ObjectMetadata;
const S3ObjectOwner = @import("s3_object_owner.zig").S3ObjectOwner;
const S3Permission = @import("s3_permission.zig").S3Permission;
const S3ReplicateObjectOperation = @import("s3_replicate_object_operation.zig").S3ReplicateObjectOperation;
const S3Retention = @import("s3_retention.zig").S3Retention;
const S3SSEAlgorithm = @import("s3_sse_algorithm.zig").S3SSEAlgorithm;
const S3SetObjectAclOperation = @import("s3_set_object_acl_operation.zig").S3SetObjectAclOperation;
const S3SetObjectLegalHoldOperation = @import("s3_set_object_legal_hold_operation.zig").S3SetObjectLegalHoldOperation;
const S3SetObjectRetentionOperation = @import("s3_set_object_retention_operation.zig").S3SetObjectRetentionOperation;
const S3SetObjectTaggingOperation = @import("s3_set_object_tagging_operation.zig").S3SetObjectTaggingOperation;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;
const S3Tag = @import("s3_tag.zig").S3Tag;
const S3UpdateObjectEncryptionOperation = @import("s3_update_object_encryption_operation.zig").S3UpdateObjectEncryptionOperation;
const S3UpdateObjectEncryptionSSEKMS = @import("s3_update_object_encryption_ssekms.zig").S3UpdateObjectEncryptionSSEKMS;
const SSEKMS = @import("ssekms.zig").SSEKMS;
const SSES3 = @import("sses3.zig").SSES3;
const Scope = @import("scope.zig").Scope;
const ScopePermission = @import("scope_permission.zig").ScopePermission;
const SelectionCriteria = @import("selection_criteria.zig").SelectionCriteria;
const SourceSelectionCriteria = @import("source_selection_criteria.zig").SourceSelectionCriteria;
const SseKmsEncryptedObjects = @import("sse_kms_encrypted_objects.zig").SseKmsEncryptedObjects;
const SseKmsEncryptedObjectsStatus = @import("sse_kms_encrypted_objects_status.zig").SseKmsEncryptedObjectsStatus;
const StorageLensAwsOrg = @import("storage_lens_aws_org.zig").StorageLensAwsOrg;
const StorageLensConfiguration = @import("storage_lens_configuration.zig").StorageLensConfiguration;
const StorageLensDataExport = @import("storage_lens_data_export.zig").StorageLensDataExport;
const StorageLensDataExportEncryption = @import("storage_lens_data_export_encryption.zig").StorageLensDataExportEncryption;
const StorageLensExpandedPrefixesDataExport = @import("storage_lens_expanded_prefixes_data_export.zig").StorageLensExpandedPrefixesDataExport;
const StorageLensGroup = @import("storage_lens_group.zig").StorageLensGroup;
const StorageLensGroupAndOperator = @import("storage_lens_group_and_operator.zig").StorageLensGroupAndOperator;
const StorageLensGroupFilter = @import("storage_lens_group_filter.zig").StorageLensGroupFilter;
const StorageLensGroupLevel = @import("storage_lens_group_level.zig").StorageLensGroupLevel;
const StorageLensGroupLevelSelectionCriteria = @import("storage_lens_group_level_selection_criteria.zig").StorageLensGroupLevelSelectionCriteria;
const StorageLensGroupOrOperator = @import("storage_lens_group_or_operator.zig").StorageLensGroupOrOperator;
const StorageLensTableDestination = @import("storage_lens_table_destination.zig").StorageLensTableDestination;
const StorageLensTag = @import("storage_lens_tag.zig").StorageLensTag;
const Tag = @import("tag.zig").Tag;
const Tagging = @import("tagging.zig").Tagging;
const Transition = @import("transition.zig").Transition;
const TransitionStorageClass = @import("transition_storage_class.zig").TransitionStorageClass;
const VersioningConfiguration = @import("versioning_configuration.zig").VersioningConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

pub fn deserializeAccessGrantsInstancesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListAccessGrantsInstanceEntry {
    var list: std.ArrayList(ListAccessGrantsInstanceEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListAccessGrantsInstanceEntry(reader, alloc));
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

pub fn deserializeAccessGrantsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListAccessGrantEntry {
    var list: std.ArrayList(ListAccessGrantEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListAccessGrantEntry(reader, alloc));
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

pub fn deserializeAccessGrantsLocationsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListAccessGrantsLocationsEntry {
    var list: std.ArrayList(ListAccessGrantsLocationsEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListAccessGrantsLocationsEntry(reader, alloc));
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

pub fn deserializeAccessPointList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AccessPoint {
    var list: std.ArrayList(AccessPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAccessPoint(reader, alloc));
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

pub fn deserializeBuckets(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCallerAccessGrantsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListCallerAccessGrantsEntry {
    var list: std.ArrayList(ListCallerAccessGrantsEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListCallerAccessGrantsEntry(reader, alloc));
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

pub fn deserializeJobFailureList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const JobFailure {
    var list: std.ArrayList(JobFailure) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeJobFailure(reader, alloc));
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

pub fn deserializeJobListDescriptorList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const JobListDescriptor {
    var list: std.ArrayList(JobListDescriptor) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeJobListDescriptor(reader, alloc));
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

pub fn deserializeJobManifestFieldList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const JobManifestFieldName {
    var list: std.ArrayList(JobManifestFieldName) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(JobManifestFieldName, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeMatchAnyPrefix(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeMatchAnySuffix(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeMatchAnyTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const S3Tag {
    var list: std.ArrayList(S3Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeS3Tag(reader, alloc));
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

pub fn deserializeMultiRegionAccessPointRegionalResponseList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MultiRegionAccessPointRegionalResponse {
    var list: std.ArrayList(MultiRegionAccessPointRegionalResponse) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMultiRegionAccessPointRegionalResponse(reader, alloc));
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

pub fn deserializeMultiRegionAccessPointReportList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MultiRegionAccessPointReport {
    var list: std.ArrayList(MultiRegionAccessPointReport) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMultiRegionAccessPointReport(reader, alloc));
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

pub fn deserializeObjectLambdaAccessPointList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ObjectLambdaAccessPoint {
    var list: std.ArrayList(ObjectLambdaAccessPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeObjectLambdaAccessPoint(reader, alloc));
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

pub fn deserializeObjectLambdaAllowedFeaturesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ObjectLambdaAllowedFeature {
    var list: std.ArrayList(ObjectLambdaAllowedFeature) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(ObjectLambdaAllowedFeature, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeObjectLambdaTransformationConfigurationActionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ObjectLambdaTransformationConfigurationAction {
    var list: std.ArrayList(ObjectLambdaTransformationConfigurationAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(ObjectLambdaTransformationConfigurationAction, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeObjectLambdaTransformationConfigurationsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ObjectLambdaTransformationConfiguration {
    var list: std.ArrayList(ObjectLambdaTransformationConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeObjectLambdaTransformationConfiguration(reader, alloc));
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

pub fn deserializePrefixesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRegionCreationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Region {
    var list: std.ArrayList(Region) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRegion(reader, alloc));
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

pub fn deserializeRegionReportList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RegionReport {
    var list: std.ArrayList(RegionReport) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRegionReport(reader, alloc));
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

pub fn deserializeRegionalBucketList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RegionalBucket {
    var list: std.ArrayList(RegionalBucket) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRegionalBucket(reader, alloc));
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

pub fn deserializeRegions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRouteList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MultiRegionAccessPointRoute {
    var list: std.ArrayList(MultiRegionAccessPointRoute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMultiRegionAccessPointRoute(reader, alloc));
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

pub fn deserializeS3GrantList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const S3Grant {
    var list: std.ArrayList(S3Grant) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeS3Grant(reader, alloc));
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

pub fn deserializeS3TagSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const S3Tag {
    var list: std.ArrayList(S3Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeS3Tag(reader, alloc));
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

pub fn deserializeScopePermissionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ScopePermission {
    var list: std.ArrayList(ScopePermission) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(ScopePermission, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeStorageLensConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListStorageLensConfigurationEntry {
    var list: std.ArrayList(ListStorageLensConfigurationEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListStorageLensConfigurationEntry(reader, alloc));
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

pub fn deserializeStorageLensGroupLevelExclude(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStorageLensGroupLevelInclude(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStorageLensGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListStorageLensGroupEntry {
    var list: std.ArrayList(ListStorageLensGroupEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListStorageLensGroupEntry(reader, alloc));
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

pub fn deserializeStorageLensTags(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StorageLensTag {
    var list: std.ArrayList(StorageLensTag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStorageLensTag(reader, alloc));
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

pub fn deserializeTagList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
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

pub fn deserializeEndpoints(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
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

pub fn deserializeS3UserMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
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

pub fn deserializeUserArguments(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
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

pub fn deserializeAbortIncompleteMultipartUpload(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AbortIncompleteMultipartUpload {
    _ = alloc;
    var result: AbortIncompleteMultipartUpload = undefined;
    result.days_after_initiation = 0;
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

pub fn deserializeAccessGrantsLocationConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessGrantsLocationConfiguration {
    var result: AccessGrantsLocationConfiguration = undefined;
    result.s3_sub_prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3SubPrefix")) {
                    result.s3_sub_prefix = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAccessPoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessPoint {
    var result: AccessPoint = undefined;
    result.access_point_arn = null;
    result.alias = null;
    result.bucket_account_id = null;
    result.data_source_id = null;
    result.data_source_type = null;
    result.vpc_configuration = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessPointArn")) {
                    result.access_point_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataSourceId")) {
                    result.data_source_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataSourceType")) {
                    result.data_source_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NetworkOrigin")) {
                    result.network_origin = std.meta.stringToEnum(NetworkOrigin, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcConfiguration")) {
                    result.vpc_configuration = try deserializeVpcConfiguration(reader, alloc);
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

pub fn deserializeAccountLevel(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccountLevel {
    var result: AccountLevel = undefined;
    result.activity_metrics = null;
    result.advanced_cost_optimization_metrics = null;
    result.advanced_data_protection_metrics = null;
    result.advanced_performance_metrics = null;
    result.detailed_status_codes_metrics = null;
    result.storage_lens_group_level = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActivityMetrics")) {
                    result.activity_metrics = try deserializeActivityMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AdvancedCostOptimizationMetrics")) {
                    result.advanced_cost_optimization_metrics = try deserializeAdvancedCostOptimizationMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AdvancedDataProtectionMetrics")) {
                    result.advanced_data_protection_metrics = try deserializeAdvancedDataProtectionMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AdvancedPerformanceMetrics")) {
                    result.advanced_performance_metrics = try deserializeAdvancedPerformanceMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "BucketLevel")) {
                    result.bucket_level = try deserializeBucketLevel(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DetailedStatusCodesMetrics")) {
                    result.detailed_status_codes_metrics = try deserializeDetailedStatusCodesMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StorageLensGroupLevel")) {
                    result.storage_lens_group_level = try deserializeStorageLensGroupLevel(reader, alloc);
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

pub fn deserializeActivityMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ActivityMetrics {
    _ = alloc;
    var result: ActivityMetrics = undefined;
    result.is_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeAdvancedCostOptimizationMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdvancedCostOptimizationMetrics {
    _ = alloc;
    var result: AdvancedCostOptimizationMetrics = undefined;
    result.is_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeAdvancedDataProtectionMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdvancedDataProtectionMetrics {
    _ = alloc;
    var result: AdvancedDataProtectionMetrics = undefined;
    result.is_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeAdvancedPerformanceMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdvancedPerformanceMetrics {
    _ = alloc;
    var result: AdvancedPerformanceMetrics = undefined;
    result.is_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeAsyncErrorDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AsyncErrorDetails {
    var result: AsyncErrorDetails = undefined;
    result.code = null;
    result.message = null;
    result.request_id = null;
    result.resource = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestId")) {
                    result.request_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resource")) {
                    result.resource = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAsyncOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AsyncOperation {
    var result: AsyncOperation = undefined;
    result.creation_time = null;
    result.operation = null;
    result.request_parameters = null;
    result.request_status = null;
    result.request_token_arn = null;
    result.response_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Operation")) {
                    result.operation = std.meta.stringToEnum(AsyncOperationName, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestParameters")) {
                    result.request_parameters = try deserializeAsyncRequestParameters(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RequestStatus")) {
                    result.request_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestTokenARN")) {
                    result.request_token_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseDetails")) {
                    result.response_details = try deserializeAsyncResponseDetails(reader, alloc);
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

pub fn deserializeAsyncRequestParameters(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AsyncRequestParameters {
    var result: AsyncRequestParameters = undefined;
    result.create_multi_region_access_point_request = null;
    result.delete_multi_region_access_point_request = null;
    result.put_multi_region_access_point_policy_request = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateMultiRegionAccessPointRequest")) {
                    result.create_multi_region_access_point_request = try deserializeCreateMultiRegionAccessPointInput(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DeleteMultiRegionAccessPointRequest")) {
                    result.delete_multi_region_access_point_request = try deserializeDeleteMultiRegionAccessPointInput(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PutMultiRegionAccessPointPolicyRequest")) {
                    result.put_multi_region_access_point_policy_request = try deserializePutMultiRegionAccessPointPolicyInput(reader, alloc);
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

pub fn deserializeAsyncResponseDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AsyncResponseDetails {
    var result: AsyncResponseDetails = undefined;
    result.error_details = null;
    result.multi_region_access_point_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorDetails")) {
                    result.error_details = try deserializeAsyncErrorDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MultiRegionAccessPointDetails")) {
                    result.multi_region_access_point_details = try deserializeMultiRegionAccessPointsAsyncResponse(reader, alloc);
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

pub fn deserializeBucketLevel(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BucketLevel {
    var result: BucketLevel = undefined;
    result.activity_metrics = null;
    result.advanced_cost_optimization_metrics = null;
    result.advanced_data_protection_metrics = null;
    result.advanced_performance_metrics = null;
    result.detailed_status_codes_metrics = null;
    result.prefix_level = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActivityMetrics")) {
                    result.activity_metrics = try deserializeActivityMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AdvancedCostOptimizationMetrics")) {
                    result.advanced_cost_optimization_metrics = try deserializeAdvancedCostOptimizationMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AdvancedDataProtectionMetrics")) {
                    result.advanced_data_protection_metrics = try deserializeAdvancedDataProtectionMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AdvancedPerformanceMetrics")) {
                    result.advanced_performance_metrics = try deserializeAdvancedPerformanceMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DetailedStatusCodesMetrics")) {
                    result.detailed_status_codes_metrics = try deserializeDetailedStatusCodesMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PrefixLevel")) {
                    result.prefix_level = try deserializePrefixLevel(reader, alloc);
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

pub fn deserializeCloudWatchMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudWatchMetrics {
    _ = alloc;
    var result: CloudWatchMetrics = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeCreateMultiRegionAccessPointInput(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CreateMultiRegionAccessPointInput {
    var result: CreateMultiRegionAccessPointInput = undefined;
    result.public_access_block = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicAccessBlock")) {
                    result.public_access_block = try deserializePublicAccessBlockConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionCreationList(reader, alloc, "Region");
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

pub fn deserializeCredentials(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Credentials {
    var result: Credentials = undefined;
    result.access_key_id = null;
    result.expiration = null;
    result.secret_access_key = null;
    result.session_token = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeDeleteMarkerReplication(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeleteMarkerReplication {
    _ = alloc;
    var result: DeleteMarkerReplication = undefined;
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

pub fn deserializeDeleteMultiRegionAccessPointInput(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeleteMultiRegionAccessPointInput {
    var result: DeleteMultiRegionAccessPointInput = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
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
                    result.storage_class = std.meta.stringToEnum(ReplicationStorageClass, try reader.readElementText());
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

pub fn deserializeDetailedStatusCodesMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DetailedStatusCodesMetrics {
    _ = alloc;
    var result: DetailedStatusCodesMetrics = undefined;
    result.is_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeEstablishedMultiRegionAccessPointPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EstablishedMultiRegionAccessPointPolicy {
    var result: EstablishedMultiRegionAccessPointPolicy = undefined;
    result.policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeExclude(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Exclude {
    var result: Exclude = undefined;
    result.buckets = null;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Buckets")) {
                    result.buckets = try deserializeBuckets(reader, alloc, "Arn");
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegions(reader, alloc, "Region");
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

pub fn deserializeGrantee(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Grantee {
    var result: Grantee = undefined;
    result.grantee_identifier = null;
    result.grantee_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GranteeIdentifier")) {
                    result.grantee_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GranteeType")) {
                    result.grantee_type = std.meta.stringToEnum(GranteeType, try reader.readElementText());
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

pub fn deserializeInclude(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Include {
    var result: Include = undefined;
    result.buckets = null;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Buckets")) {
                    result.buckets = try deserializeBuckets(reader, alloc, "Arn");
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegions(reader, alloc, "Region");
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

pub fn deserializeJobDescriptor(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobDescriptor {
    var result: JobDescriptor = undefined;
    result.confirmation_required = null;
    result.creation_time = null;
    result.description = null;
    result.failure_reasons = null;
    result.generated_manifest_descriptor = null;
    result.job_arn = null;
    result.job_id = null;
    result.manifest = null;
    result.manifest_generator = null;
    result.operation = null;
    result.priority = 0;
    result.progress_summary = null;
    result.report = null;
    result.role_arn = null;
    result.status = null;
    result.status_update_reason = null;
    result.suspended_cause = null;
    result.suspended_date = null;
    result.termination_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConfirmationRequired")) {
                    result.confirmation_required = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureReasons")) {
                    result.failure_reasons = try deserializeJobFailureList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "GeneratedManifestDescriptor")) {
                    result.generated_manifest_descriptor = try deserializeS3GeneratedManifestDescriptor(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "JobArn")) {
                    result.job_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JobId")) {
                    result.job_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Manifest")) {
                    result.manifest = try deserializeJobManifest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ManifestGenerator")) {
                    try reader.skipElement();
                } else if (std.mem.eql(u8, e.local, "Operation")) {
                    result.operation = try deserializeJobOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProgressSummary")) {
                    result.progress_summary = try deserializeJobProgressSummary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Report")) {
                    result.report = try deserializeJobReport(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(JobStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusUpdateReason")) {
                    result.status_update_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuspendedCause")) {
                    result.suspended_cause = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuspendedDate")) {
                    result.suspended_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TerminationDate")) {
                    result.termination_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeJobFailure(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobFailure {
    var result: JobFailure = undefined;
    result.failure_code = null;
    result.failure_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailureCode")) {
                    result.failure_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureReason")) {
                    result.failure_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeJobListDescriptor(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobListDescriptor {
    var result: JobListDescriptor = undefined;
    result.creation_time = null;
    result.description = null;
    result.job_id = null;
    result.operation = null;
    result.priority = 0;
    result.progress_summary = null;
    result.status = null;
    result.termination_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JobId")) {
                    result.job_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Operation")) {
                    result.operation = std.meta.stringToEnum(OperationName, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProgressSummary")) {
                    result.progress_summary = try deserializeJobProgressSummary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(JobStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TerminationDate")) {
                    result.termination_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeJobManifest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobManifest {
    var result: JobManifest = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Location")) {
                    result.location = try deserializeJobManifestLocation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Spec")) {
                    result.spec = try deserializeJobManifestSpec(reader, alloc);
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

pub fn deserializeJobManifestLocation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobManifestLocation {
    var result: JobManifestLocation = undefined;
    result.object_version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectArn")) {
                    result.object_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectVersionId")) {
                    result.object_version_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeJobManifestSpec(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobManifestSpec {
    var result: JobManifestSpec = undefined;
    result.fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Fields")) {
                    result.fields = try deserializeJobManifestFieldList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(JobManifestFormat, try reader.readElementText());
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

pub fn deserializeJobOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobOperation {
    var result: JobOperation = undefined;
    result.lambda_invoke = null;
    result.s3_compute_object_checksum = null;
    result.s3_delete_object_tagging = null;
    result.s3_initiate_restore_object = null;
    result.s3_put_object_acl = null;
    result.s3_put_object_copy = null;
    result.s3_put_object_legal_hold = null;
    result.s3_put_object_retention = null;
    result.s3_put_object_tagging = null;
    result.s3_replicate_object = null;
    result.s3_update_object_encryption = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LambdaInvoke")) {
                    result.lambda_invoke = try deserializeLambdaInvokeOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3ComputeObjectChecksum")) {
                    result.s3_compute_object_checksum = try deserializeS3ComputeObjectChecksumOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3DeleteObjectTagging")) {
                    result.s3_delete_object_tagging = try deserializeS3DeleteObjectTaggingOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3InitiateRestoreObject")) {
                    result.s3_initiate_restore_object = try deserializeS3InitiateRestoreObjectOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectAcl")) {
                    result.s3_put_object_acl = try deserializeS3SetObjectAclOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectCopy")) {
                    result.s3_put_object_copy = try deserializeS3CopyObjectOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectLegalHold")) {
                    result.s3_put_object_legal_hold = try deserializeS3SetObjectLegalHoldOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectRetention")) {
                    result.s3_put_object_retention = try deserializeS3SetObjectRetentionOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectTagging")) {
                    result.s3_put_object_tagging = try deserializeS3SetObjectTaggingOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3ReplicateObject")) {
                    result.s3_replicate_object = try deserializeS3ReplicateObjectOperation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3UpdateObjectEncryption")) {
                    result.s3_update_object_encryption = try deserializeS3UpdateObjectEncryptionOperation(reader, alloc);
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

pub fn deserializeJobProgressSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobProgressSummary {
    var result: JobProgressSummary = undefined;
    result.number_of_tasks_failed = null;
    result.number_of_tasks_succeeded = null;
    result.timers = null;
    result.total_number_of_tasks = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NumberOfTasksFailed")) {
                    result.number_of_tasks_failed = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NumberOfTasksSucceeded")) {
                    result.number_of_tasks_succeeded = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Timers")) {
                    result.timers = try deserializeJobTimers(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TotalNumberOfTasks")) {
                    result.total_number_of_tasks = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeJobReport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobReport {
    var result: JobReport = undefined;
    result.bucket = null;
    result.expected_bucket_owner = null;
    result.format = null;
    result.prefix = null;
    result.report_scope = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ExpectedBucketOwner")) {
                    result.expected_bucket_owner = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(JobReportFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReportScope")) {
                    result.report_scope = std.meta.stringToEnum(JobReportScope, try reader.readElementText());
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

pub fn deserializeJobTimers(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JobTimers {
    _ = alloc;
    var result: JobTimers = undefined;
    result.elapsed_time_in_active_seconds = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ElapsedTimeInActiveSeconds")) {
                    result.elapsed_time_in_active_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeLambdaInvokeOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LambdaInvokeOperation {
    var result: LambdaInvokeOperation = undefined;
    result.function_arn = null;
    result.invocation_schema_version = null;
    result.user_arguments = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FunctionArn")) {
                    result.function_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationSchemaVersion")) {
                    result.invocation_schema_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserArguments")) {
                    result.user_arguments = try deserializeUserArguments(reader, alloc, "entry");
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
    result.days = 0;
    result.expired_object_delete_marker = false;
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

pub fn deserializeLifecycleRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LifecycleRule {
    var result: LifecycleRule = undefined;
    result.abort_incomplete_multipart_upload = null;
    result.expiration = null;
    result.filter = null;
    result.id = null;
    result.noncurrent_version_expiration = null;
    result.noncurrent_version_transitions = null;
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
                } else if (std.mem.eql(u8, e.local, "NoncurrentVersionTransitions")) {
                    result.noncurrent_version_transitions = try deserializeNoncurrentVersionTransitionList(reader, alloc, "NoncurrentVersionTransition");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ExpirationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Transitions")) {
                    result.transitions = try deserializeTransitionList(reader, alloc, "Transition");
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
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeS3TagSet(reader, alloc, "member");
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
                    result.tag = try deserializeS3Tag(reader, alloc);
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

pub fn deserializeListAccessGrantEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListAccessGrantEntry {
    var result: ListAccessGrantEntry = undefined;
    result.access_grant_arn = null;
    result.access_grant_id = null;
    result.access_grants_location_configuration = null;
    result.access_grants_location_id = null;
    result.application_arn = null;
    result.created_at = null;
    result.grantee = null;
    result.grant_scope = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessGrantArn")) {
                    result.access_grant_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantId")) {
                    result.access_grant_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationConfiguration")) {
                    result.access_grants_location_configuration = try deserializeAccessGrantsLocationConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationId")) {
                    result.access_grants_location_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationArn")) {
                    result.application_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeGrantee(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "GrantScope")) {
                    result.grant_scope = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeListAccessGrantsInstanceEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListAccessGrantsInstanceEntry {
    var result: ListAccessGrantsInstanceEntry = undefined;
    result.access_grants_instance_arn = null;
    result.access_grants_instance_id = null;
    result.created_at = null;
    result.identity_center_application_arn = null;
    result.identity_center_arn = null;
    result.identity_center_instance_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessGrantsInstanceArn")) {
                    result.access_grants_instance_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsInstanceId")) {
                    result.access_grants_instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IdentityCenterApplicationArn")) {
                    result.identity_center_application_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdentityCenterArn")) {
                    result.identity_center_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdentityCenterInstanceArn")) {
                    result.identity_center_instance_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeListAccessGrantsLocationsEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListAccessGrantsLocationsEntry {
    var result: ListAccessGrantsLocationsEntry = undefined;
    result.access_grants_location_arn = null;
    result.access_grants_location_id = null;
    result.created_at = null;
    result.iam_role_arn = null;
    result.location_scope = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessGrantsLocationArn")) {
                    result.access_grants_location_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationId")) {
                    result.access_grants_location_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IAMRoleArn")) {
                    result.iam_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocationScope")) {
                    result.location_scope = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeListCallerAccessGrantsEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListCallerAccessGrantsEntry {
    var result: ListCallerAccessGrantsEntry = undefined;
    result.application_arn = null;
    result.grant_scope = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationArn")) {
                    result.application_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GrantScope")) {
                    result.grant_scope = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeListStorageLensConfigurationEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListStorageLensConfigurationEntry {
    var result: ListStorageLensConfigurationEntry = undefined;
    result.is_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HomeRegion")) {
                    result.home_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageLensArn")) {
                    result.storage_lens_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeListStorageLensGroupEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListStorageLensGroupEntry {
    var result: ListStorageLensGroupEntry = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HomeRegion")) {
                    result.home_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageLensGroupArn")) {
                    result.storage_lens_group_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeMatchObjectAge(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MatchObjectAge {
    _ = alloc;
    var result: MatchObjectAge = undefined;
    result.days_greater_than = 0;
    result.days_less_than = 0;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DaysGreaterThan")) {
                    result.days_greater_than = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DaysLessThan")) {
                    result.days_less_than = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeMatchObjectSize(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MatchObjectSize {
    _ = alloc;
    var result: MatchObjectSize = undefined;
    result.bytes_greater_than = 0;
    result.bytes_less_than = 0;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BytesGreaterThan")) {
                    result.bytes_greater_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BytesLessThan")) {
                    result.bytes_less_than = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeMultiRegionAccessPointPolicyDocument(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MultiRegionAccessPointPolicyDocument {
    var result: MultiRegionAccessPointPolicyDocument = undefined;
    result.established = null;
    result.proposed = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Established")) {
                    result.established = try deserializeEstablishedMultiRegionAccessPointPolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Proposed")) {
                    result.proposed = try deserializeProposedMultiRegionAccessPointPolicy(reader, alloc);
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

pub fn deserializeMultiRegionAccessPointRegionalResponse(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MultiRegionAccessPointRegionalResponse {
    var result: MultiRegionAccessPointRegionalResponse = undefined;
    result.name = null;
    result.request_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestStatus")) {
                    result.request_status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeMultiRegionAccessPointReport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MultiRegionAccessPointReport {
    var result: MultiRegionAccessPointReport = undefined;
    result.alias = null;
    result.created_at = null;
    result.name = null;
    result.public_access_block = null;
    result.regions = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicAccessBlock")) {
                    result.public_access_block = try deserializePublicAccessBlockConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionReportList(reader, alloc, "Region");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(MultiRegionAccessPointStatus, try reader.readElementText());
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

pub fn deserializeMultiRegionAccessPointRoute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MultiRegionAccessPointRoute {
    var result: MultiRegionAccessPointRoute = undefined;
    result.bucket = null;
    result.region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficDialPercentage")) {
                    result.traffic_dial_percentage = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
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

pub fn deserializeMultiRegionAccessPointsAsyncResponse(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MultiRegionAccessPointsAsyncResponse {
    var result: MultiRegionAccessPointsAsyncResponse = undefined;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeMultiRegionAccessPointRegionalResponseList(reader, alloc, "Region");
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
    result.noncurrent_days = 0;
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
    result.noncurrent_days = 0;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NoncurrentDays")) {
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

pub fn deserializeObjectEncryption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectEncryption {
    var result: ObjectEncryption = undefined;
    result.ssekms = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SSE-KMS")) {
                    result.ssekms = try deserializeS3UpdateObjectEncryptionSSEKMS(reader, alloc);
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

pub fn deserializeObjectLambdaAccessPoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLambdaAccessPoint {
    var result: ObjectLambdaAccessPoint = undefined;
    result.alias = null;
    result.object_lambda_access_point_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try deserializeObjectLambdaAccessPointAlias(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectLambdaAccessPointArn")) {
                    result.object_lambda_access_point_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeObjectLambdaAccessPointAlias(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLambdaAccessPointAlias {
    var result: ObjectLambdaAccessPointAlias = undefined;
    result.status = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ObjectLambdaAccessPointAliasStatus, try reader.readElementText());
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

pub fn deserializeObjectLambdaConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLambdaConfiguration {
    var result: ObjectLambdaConfiguration = undefined;
    result.allowed_features = null;
    result.cloud_watch_metrics_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedFeatures")) {
                    result.allowed_features = try deserializeObjectLambdaAllowedFeaturesList(reader, alloc, "AllowedFeature");
                } else if (std.mem.eql(u8, e.local, "CloudWatchMetricsEnabled")) {
                    result.cloud_watch_metrics_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportingAccessPoint")) {
                    result.supporting_access_point = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransformationConfigurations")) {
                    result.transformation_configurations = try deserializeObjectLambdaTransformationConfigurationsList(reader, alloc, "TransformationConfiguration");
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

pub fn deserializeObjectLambdaTransformationConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ObjectLambdaTransformationConfiguration {
    var result: ObjectLambdaTransformationConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Actions")) {
                    result.actions = try deserializeObjectLambdaTransformationConfigurationActionsList(reader, alloc, "Action");
                } else if (std.mem.eql(u8, e.local, "ContentTransformation")) {
                    try reader.skipElement();
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
    result.is_public = false;
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

pub fn deserializePrefixLevel(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PrefixLevel {
    var result: PrefixLevel = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StorageMetrics")) {
                    result.storage_metrics = try deserializePrefixLevelStorageMetrics(reader, alloc);
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

pub fn deserializePrefixLevelStorageMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PrefixLevelStorageMetrics {
    var result: PrefixLevelStorageMetrics = undefined;
    result.is_enabled = false;
    result.selection_criteria = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SelectionCriteria")) {
                    result.selection_criteria = try deserializeSelectionCriteria(reader, alloc);
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

pub fn deserializeProposedMultiRegionAccessPointPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ProposedMultiRegionAccessPointPolicy {
    var result: ProposedMultiRegionAccessPointPolicy = undefined;
    result.policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try alloc.dupe(u8, try reader.readElementText());
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
    result.block_public_acls = false;
    result.block_public_policy = false;
    result.ignore_public_acls = false;
    result.restrict_public_buckets = false;
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

pub fn deserializePutMultiRegionAccessPointPolicyInput(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PutMultiRegionAccessPointPolicyInput {
    var result: PutMultiRegionAccessPointPolicyInput = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRegion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Region {
    var result: Region = undefined;
    result.bucket_account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRegionReport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RegionReport {
    var result: RegionReport = undefined;
    result.bucket = null;
    result.bucket_account_id = null;
    result.region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRegionalBucket(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RegionalBucket {
    var result: RegionalBucket = undefined;
    result.bucket_arn = null;
    result.outpost_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketArn")) {
                    result.bucket_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutpostId")) {
                    result.outpost_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicAccessBlockEnabled")) {
                    result.public_access_block_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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
                } else if (std.mem.eql(u8, e.local, "Rules")) {
                    result.rules = try deserializeReplicationRules(reader, alloc, "Rule");
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
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeleteMarkerReplication")) {
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
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeS3TagSet(reader, alloc, "member");
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
                    result.tag = try deserializeS3Tag(reader, alloc);
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

pub fn deserializeS3AccessControlList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3AccessControlList {
    var result: S3AccessControlList = undefined;
    result.grants = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grants")) {
                    result.grants = try deserializeS3GrantList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeS3ObjectOwner(reader, alloc);
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

pub fn deserializeS3AccessControlPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3AccessControlPolicy {
    var result: S3AccessControlPolicy = undefined;
    result.access_control_list = null;
    result.canned_access_control_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlList")) {
                    result.access_control_list = try deserializeS3AccessControlList(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CannedAccessControlList")) {
                    result.canned_access_control_list = std.meta.stringToEnum(S3CannedAccessControlList, try reader.readElementText());
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

pub fn deserializeS3BucketDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3BucketDestination {
    var result: S3BucketDestination = undefined;
    result.encryption = null;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Encryption")) {
                    result.encryption = try deserializeStorageLensDataExportEncryption(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(Format, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputSchemaVersion")) {
                    result.output_schema_version = std.meta.stringToEnum(OutputSchemaVersion, try reader.readElementText());
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

pub fn deserializeS3ComputeObjectChecksumOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3ComputeObjectChecksumOperation {
    _ = alloc;
    var result: S3ComputeObjectChecksumOperation = undefined;
    result.checksum_algorithm = null;
    result.checksum_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = std.meta.stringToEnum(ComputeObjectChecksumAlgorithm, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = std.meta.stringToEnum(ComputeObjectChecksumType, try reader.readElementText());
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

pub fn deserializeS3CopyObjectOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3CopyObjectOperation {
    var result: S3CopyObjectOperation = undefined;
    result.access_control_grants = null;
    result.bucket_key_enabled = false;
    result.canned_access_control_list = null;
    result.checksum_algorithm = null;
    result.metadata_directive = null;
    result.modified_since_constraint = null;
    result.new_object_metadata = null;
    result.new_object_tagging = null;
    result.object_lock_legal_hold_status = null;
    result.object_lock_mode = null;
    result.object_lock_retain_until_date = null;
    result.redirect_location = null;
    result.requester_pays = false;
    result.sse_aws_kms_key_id = null;
    result.storage_class = null;
    result.target_key_prefix = null;
    result.target_resource = null;
    result.un_modified_since_constraint = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlGrants")) {
                    result.access_control_grants = try deserializeS3GrantList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "BucketKeyEnabled")) {
                    result.bucket_key_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CannedAccessControlList")) {
                    result.canned_access_control_list = std.meta.stringToEnum(S3CannedAccessControlList, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = std.meta.stringToEnum(S3ChecksumAlgorithm, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetadataDirective")) {
                    result.metadata_directive = std.meta.stringToEnum(S3MetadataDirective, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModifiedSinceConstraint")) {
                    result.modified_since_constraint = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NewObjectMetadata")) {
                    result.new_object_metadata = try deserializeS3ObjectMetadata(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NewObjectTagging")) {
                    result.new_object_tagging = try deserializeS3TagSet(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ObjectLockLegalHoldStatus")) {
                    result.object_lock_legal_hold_status = std.meta.stringToEnum(S3ObjectLockLegalHoldStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectLockMode")) {
                    result.object_lock_mode = std.meta.stringToEnum(S3ObjectLockMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectLockRetainUntilDate")) {
                    result.object_lock_retain_until_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "RedirectLocation")) {
                    result.redirect_location = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequesterPays")) {
                    result.requester_pays = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SSEAwsKmsKeyId")) {
                    result.sse_aws_kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(S3StorageClass, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetKeyPrefix")) {
                    result.target_key_prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetResource")) {
                    result.target_resource = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UnModifiedSinceConstraint")) {
                    result.un_modified_since_constraint = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeS3DeleteObjectTaggingOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3DeleteObjectTaggingOperation {
    _ = alloc;
    const result: S3DeleteObjectTaggingOperation = .{};
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

pub fn deserializeS3GeneratedManifestDescriptor(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3GeneratedManifestDescriptor {
    var result: S3GeneratedManifestDescriptor = undefined;
    result.format = null;
    result.location = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(GeneratedManifestFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Location")) {
                    result.location = try deserializeJobManifestLocation(reader, alloc);
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

pub fn deserializeS3Grant(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3Grant {
    var result: S3Grant = undefined;
    result.grantee = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeS3Grantee(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = std.meta.stringToEnum(S3Permission, try reader.readElementText());
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

pub fn deserializeS3Grantee(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3Grantee {
    var result: S3Grantee = undefined;
    result.display_name = null;
    result.identifier = null;
    result.type_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Identifier")) {
                    result.identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeIdentifier")) {
                    result.type_identifier = std.meta.stringToEnum(S3GranteeTypeIdentifier, try reader.readElementText());
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

pub fn deserializeS3InitiateRestoreObjectOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3InitiateRestoreObjectOperation {
    _ = alloc;
    var result: S3InitiateRestoreObjectOperation = undefined;
    result.expiration_in_days = null;
    result.glacier_job_tier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExpirationInDays")) {
                    result.expiration_in_days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "GlacierJobTier")) {
                    result.glacier_job_tier = std.meta.stringToEnum(S3GlacierJobTier, try reader.readElementText());
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

pub fn deserializeS3ObjectLockLegalHold(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3ObjectLockLegalHold {
    _ = alloc;
    var result: S3ObjectLockLegalHold = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(S3ObjectLockLegalHoldStatus, try reader.readElementText());
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

pub fn deserializeS3ObjectMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3ObjectMetadata {
    var result: S3ObjectMetadata = undefined;
    result.cache_control = null;
    result.content_disposition = null;
    result.content_encoding = null;
    result.content_language = null;
    result.content_length = null;
    result.content_md5 = null;
    result.content_type = null;
    result.http_expires_date = null;
    result.requester_charged = false;
    result.sse_algorithm = null;
    result.user_metadata = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheControl")) {
                    result.cache_control = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentDisposition")) {
                    result.content_disposition = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentEncoding")) {
                    result.content_encoding = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentLanguage")) {
                    result.content_language = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentLength")) {
                    result.content_length = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ContentMD5")) {
                    result.content_md5 = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentType")) {
                    result.content_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpExpiresDate")) {
                    result.http_expires_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "RequesterCharged")) {
                    result.requester_charged = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SSEAlgorithm")) {
                    result.sse_algorithm = std.meta.stringToEnum(S3SSEAlgorithm, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserMetadata")) {
                    result.user_metadata = try deserializeS3UserMetadata(reader, alloc, "entry");
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

pub fn deserializeS3ObjectOwner(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3ObjectOwner {
    var result: S3ObjectOwner = undefined;
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

pub fn deserializeS3ReplicateObjectOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3ReplicateObjectOperation {
    _ = alloc;
    const result: S3ReplicateObjectOperation = .{};
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

pub fn deserializeS3Retention(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3Retention {
    _ = alloc;
    var result: S3Retention = undefined;
    result.mode = null;
    result.retain_until_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = std.meta.stringToEnum(S3ObjectLockRetentionMode, try reader.readElementText());
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

pub fn deserializeS3SetObjectAclOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3SetObjectAclOperation {
    var result: S3SetObjectAclOperation = undefined;
    result.access_control_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlPolicy")) {
                    result.access_control_policy = try deserializeS3AccessControlPolicy(reader, alloc);
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

pub fn deserializeS3SetObjectLegalHoldOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3SetObjectLegalHoldOperation {
    var result: S3SetObjectLegalHoldOperation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LegalHold")) {
                    result.legal_hold = try deserializeS3ObjectLockLegalHold(reader, alloc);
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

pub fn deserializeS3SetObjectRetentionOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3SetObjectRetentionOperation {
    var result: S3SetObjectRetentionOperation = undefined;
    result.bypass_governance_retention = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BypassGovernanceRetention")) {
                    result.bypass_governance_retention = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Retention")) {
                    result.retention = try deserializeS3Retention(reader, alloc);
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

pub fn deserializeS3SetObjectTaggingOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3SetObjectTaggingOperation {
    var result: S3SetObjectTaggingOperation = undefined;
    result.tag_set = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TagSet")) {
                    result.tag_set = try deserializeS3TagSet(reader, alloc, "member");
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

pub fn deserializeS3Tag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3Tag {
    var result: S3Tag = undefined;
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

pub fn deserializeS3UpdateObjectEncryptionOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3UpdateObjectEncryptionOperation {
    var result: S3UpdateObjectEncryptionOperation = undefined;
    result.object_encryption = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ObjectEncryption")) {
                    result.object_encryption = try deserializeObjectEncryption(reader, alloc);
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

pub fn deserializeS3UpdateObjectEncryptionSSEKMS(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3UpdateObjectEncryptionSSEKMS {
    var result: S3UpdateObjectEncryptionSSEKMS = undefined;
    result.bucket_key_enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketKeyEnabled")) {
                    result.bucket_key_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KMSKeyArn")) {
                    result.kms_key_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeScope(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Scope {
    var result: Scope = undefined;
    result.permissions = null;
    result.prefixes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Permissions")) {
                    result.permissions = try deserializeScopePermissionList(reader, alloc, "Permission");
                } else if (std.mem.eql(u8, e.local, "Prefixes")) {
                    result.prefixes = try deserializePrefixesList(reader, alloc, "Prefix");
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

pub fn deserializeSelectionCriteria(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SelectionCriteria {
    var result: SelectionCriteria = undefined;
    result.delimiter = null;
    result.max_depth = null;
    result.min_storage_bytes_percentage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Delimiter")) {
                    result.delimiter = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxDepth")) {
                    result.max_depth = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinStorageBytesPercentage")) {
                    result.min_storage_bytes_percentage = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
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

pub fn deserializeStorageLensAwsOrg(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensAwsOrg {
    var result: StorageLensAwsOrg = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStorageLensConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensConfiguration {
    var result: StorageLensConfiguration = undefined;
    result.aws_org = null;
    result.data_export = null;
    result.exclude = null;
    result.expanded_prefixes_data_export = null;
    result.include = null;
    result.prefix_delimiter = null;
    result.storage_lens_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountLevel")) {
                    result.account_level = try deserializeAccountLevel(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AwsOrg")) {
                    result.aws_org = try deserializeStorageLensAwsOrg(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DataExport")) {
                    result.data_export = try deserializeStorageLensDataExport(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Exclude")) {
                    result.exclude = try deserializeExclude(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ExpandedPrefixesDataExport")) {
                    result.expanded_prefixes_data_export = try deserializeStorageLensExpandedPrefixesDataExport(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Include")) {
                    result.include = try deserializeInclude(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PrefixDelimiter")) {
                    result.prefix_delimiter = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageLensArn")) {
                    result.storage_lens_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStorageLensDataExport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensDataExport {
    var result: StorageLensDataExport = undefined;
    result.cloud_watch_metrics = null;
    result.s3_bucket_destination = null;
    result.storage_lens_table_destination = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchMetrics")) {
                    result.cloud_watch_metrics = try deserializeCloudWatchMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s3_bucket_destination = try deserializeS3BucketDestination(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StorageLensTableDestination")) {
                    result.storage_lens_table_destination = try deserializeStorageLensTableDestination(reader, alloc);
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

pub fn deserializeStorageLensDataExportEncryption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensDataExportEncryption {
    var result: StorageLensDataExportEncryption = undefined;
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

pub fn deserializeStorageLensExpandedPrefixesDataExport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensExpandedPrefixesDataExport {
    var result: StorageLensExpandedPrefixesDataExport = undefined;
    result.s3_bucket_destination = null;
    result.storage_lens_table_destination = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s3_bucket_destination = try deserializeS3BucketDestination(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StorageLensTableDestination")) {
                    result.storage_lens_table_destination = try deserializeStorageLensTableDestination(reader, alloc);
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

pub fn deserializeStorageLensGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensGroup {
    var result: StorageLensGroup = undefined;
    result.storage_lens_group_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeStorageLensGroupFilter(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageLensGroupArn")) {
                    result.storage_lens_group_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStorageLensGroupAndOperator(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensGroupAndOperator {
    var result: StorageLensGroupAndOperator = undefined;
    result.match_any_prefix = null;
    result.match_any_suffix = null;
    result.match_any_tag = null;
    result.match_object_age = null;
    result.match_object_size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MatchAnyPrefix")) {
                    result.match_any_prefix = try deserializeMatchAnyPrefix(reader, alloc, "Prefix");
                } else if (std.mem.eql(u8, e.local, "MatchAnySuffix")) {
                    result.match_any_suffix = try deserializeMatchAnySuffix(reader, alloc, "Suffix");
                } else if (std.mem.eql(u8, e.local, "MatchAnyTag")) {
                    result.match_any_tag = try deserializeMatchAnyTag(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "MatchObjectAge")) {
                    result.match_object_age = try deserializeMatchObjectAge(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MatchObjectSize")) {
                    result.match_object_size = try deserializeMatchObjectSize(reader, alloc);
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

pub fn deserializeStorageLensGroupFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensGroupFilter {
    var result: StorageLensGroupFilter = undefined;
    result.@"and" = null;
    result.match_any_prefix = null;
    result.match_any_suffix = null;
    result.match_any_tag = null;
    result.match_object_age = null;
    result.match_object_size = null;
    result.@"or" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "And")) {
                    result.@"and" = try deserializeStorageLensGroupAndOperator(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MatchAnyPrefix")) {
                    result.match_any_prefix = try deserializeMatchAnyPrefix(reader, alloc, "Prefix");
                } else if (std.mem.eql(u8, e.local, "MatchAnySuffix")) {
                    result.match_any_suffix = try deserializeMatchAnySuffix(reader, alloc, "Suffix");
                } else if (std.mem.eql(u8, e.local, "MatchAnyTag")) {
                    result.match_any_tag = try deserializeMatchAnyTag(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "MatchObjectAge")) {
                    result.match_object_age = try deserializeMatchObjectAge(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MatchObjectSize")) {
                    result.match_object_size = try deserializeMatchObjectSize(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Or")) {
                    result.@"or" = try deserializeStorageLensGroupOrOperator(reader, alloc);
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

pub fn deserializeStorageLensGroupLevel(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensGroupLevel {
    var result: StorageLensGroupLevel = undefined;
    result.selection_criteria = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SelectionCriteria")) {
                    result.selection_criteria = try deserializeStorageLensGroupLevelSelectionCriteria(reader, alloc);
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

pub fn deserializeStorageLensGroupLevelSelectionCriteria(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensGroupLevelSelectionCriteria {
    var result: StorageLensGroupLevelSelectionCriteria = undefined;
    result.exclude = null;
    result.include = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Exclude")) {
                    result.exclude = try deserializeStorageLensGroupLevelExclude(reader, alloc, "Arn");
                } else if (std.mem.eql(u8, e.local, "Include")) {
                    result.include = try deserializeStorageLensGroupLevelInclude(reader, alloc, "Arn");
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

pub fn deserializeStorageLensGroupOrOperator(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensGroupOrOperator {
    var result: StorageLensGroupOrOperator = undefined;
    result.match_any_prefix = null;
    result.match_any_suffix = null;
    result.match_any_tag = null;
    result.match_object_age = null;
    result.match_object_size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MatchAnyPrefix")) {
                    result.match_any_prefix = try deserializeMatchAnyPrefix(reader, alloc, "Prefix");
                } else if (std.mem.eql(u8, e.local, "MatchAnySuffix")) {
                    result.match_any_suffix = try deserializeMatchAnySuffix(reader, alloc, "Suffix");
                } else if (std.mem.eql(u8, e.local, "MatchAnyTag")) {
                    result.match_any_tag = try deserializeMatchAnyTag(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "MatchObjectAge")) {
                    result.match_object_age = try deserializeMatchObjectAge(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MatchObjectSize")) {
                    result.match_object_size = try deserializeMatchObjectSize(reader, alloc);
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

pub fn deserializeStorageLensTableDestination(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensTableDestination {
    var result: StorageLensTableDestination = undefined;
    result.encryption = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Encryption")) {
                    result.encryption = try deserializeStorageLensDataExportEncryption(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeStorageLensTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StorageLensTag {
    var result: StorageLensTag = undefined;
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

pub fn deserializeTransition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Transition {
    _ = alloc;
    var result: Transition = undefined;
    result.date = null;
    result.days = 0;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeVpcConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VpcConfiguration {
    var result: VpcConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn serializeBuckets(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeJobManifestFieldList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const JobManifestFieldName, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeJobStatusList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const JobStatus, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeLifecycleRules(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LifecycleRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeLifecycleRule(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMatchAnyPrefix(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMatchAnySuffix(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMatchAnyTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const S3Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeS3Tag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeNoncurrentVersionTransitionList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const NoncurrentVersionTransition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeNoncurrentVersionTransition(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeObjectLambdaAllowedFeaturesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectLambdaAllowedFeature, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeObjectLambdaTransformationConfigurationActionsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectLambdaTransformationConfigurationAction, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeObjectLambdaTransformationConfigurationsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectLambdaTransformationConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeObjectLambdaTransformationConfiguration(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePrefixesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRegionCreationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Region, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRegion(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRegions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeReplicationRules(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ReplicationRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeReplicationRule(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRouteList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MultiRegionAccessPointRoute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMultiRegionAccessPointRoute(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeS3GrantList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const S3Grant, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeS3Grant(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeS3TagSet(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const S3Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeS3Tag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeScopePermissionList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScopePermission, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStorageLensGroupLevelExclude(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStorageLensGroupLevelInclude(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStorageLensTags(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StorageLensTag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeStorageLensTag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagKeyList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTransitionList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Transition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTransition(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeS3UserMetadata(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, "<key>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.key);
        try buf.appendSlice(alloc, "</key>");
        try buf.appendSlice(alloc, "<value>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.value);
        try buf.appendSlice(alloc, "</value>");
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeUserArguments(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, "<key>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.key);
        try buf.appendSlice(alloc, "</key>");
        try buf.appendSlice(alloc, "<value>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.value);
        try buf.appendSlice(alloc, "</value>");
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAbortIncompleteMultipartUpload(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AbortIncompleteMultipartUpload) !void {
    if (value.days_after_initiation) |v| {
        try buf.appendSlice(alloc, "<DaysAfterInitiation>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DaysAfterInitiation>");
    }
}

pub fn serializeAccessControlTranslation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessControlTranslation) !void {
    try buf.appendSlice(alloc, "<Owner>");
    try buf.appendSlice(alloc, @tagName(value.owner));
    try buf.appendSlice(alloc, "</Owner>");
}

pub fn serializeAccessGrantsLocationConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessGrantsLocationConfiguration) !void {
    if (value.s3_sub_prefix) |v| {
        try buf.appendSlice(alloc, "<S3SubPrefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3SubPrefix>");
    }
}

pub fn serializeAccountLevel(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccountLevel) !void {
    if (value.activity_metrics) |v| {
        try buf.appendSlice(alloc, "<ActivityMetrics>");
        try serializeActivityMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</ActivityMetrics>");
    }
    if (value.advanced_cost_optimization_metrics) |v| {
        try buf.appendSlice(alloc, "<AdvancedCostOptimizationMetrics>");
        try serializeAdvancedCostOptimizationMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</AdvancedCostOptimizationMetrics>");
    }
    if (value.advanced_data_protection_metrics) |v| {
        try buf.appendSlice(alloc, "<AdvancedDataProtectionMetrics>");
        try serializeAdvancedDataProtectionMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</AdvancedDataProtectionMetrics>");
    }
    if (value.advanced_performance_metrics) |v| {
        try buf.appendSlice(alloc, "<AdvancedPerformanceMetrics>");
        try serializeAdvancedPerformanceMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</AdvancedPerformanceMetrics>");
    }
    try buf.appendSlice(alloc, "<BucketLevel>");
    try serializeBucketLevel(alloc, buf, value.bucket_level);
    try buf.appendSlice(alloc, "</BucketLevel>");
    if (value.detailed_status_codes_metrics) |v| {
        try buf.appendSlice(alloc, "<DetailedStatusCodesMetrics>");
        try serializeDetailedStatusCodesMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</DetailedStatusCodesMetrics>");
    }
    if (value.storage_lens_group_level) |v| {
        try buf.appendSlice(alloc, "<StorageLensGroupLevel>");
        try serializeStorageLensGroupLevel(alloc, buf, v);
        try buf.appendSlice(alloc, "</StorageLensGroupLevel>");
    }
}

pub fn serializeActivityMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ActivityMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(alloc, "<IsEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsEnabled>");
    }
}

pub fn serializeAdvancedCostOptimizationMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdvancedCostOptimizationMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(alloc, "<IsEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsEnabled>");
    }
}

pub fn serializeAdvancedDataProtectionMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdvancedDataProtectionMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(alloc, "<IsEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsEnabled>");
    }
}

pub fn serializeAdvancedPerformanceMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdvancedPerformanceMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(alloc, "<IsEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsEnabled>");
    }
}

pub fn serializeBucketLevel(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BucketLevel) !void {
    if (value.activity_metrics) |v| {
        try buf.appendSlice(alloc, "<ActivityMetrics>");
        try serializeActivityMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</ActivityMetrics>");
    }
    if (value.advanced_cost_optimization_metrics) |v| {
        try buf.appendSlice(alloc, "<AdvancedCostOptimizationMetrics>");
        try serializeAdvancedCostOptimizationMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</AdvancedCostOptimizationMetrics>");
    }
    if (value.advanced_data_protection_metrics) |v| {
        try buf.appendSlice(alloc, "<AdvancedDataProtectionMetrics>");
        try serializeAdvancedDataProtectionMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</AdvancedDataProtectionMetrics>");
    }
    if (value.advanced_performance_metrics) |v| {
        try buf.appendSlice(alloc, "<AdvancedPerformanceMetrics>");
        try serializeAdvancedPerformanceMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</AdvancedPerformanceMetrics>");
    }
    if (value.detailed_status_codes_metrics) |v| {
        try buf.appendSlice(alloc, "<DetailedStatusCodesMetrics>");
        try serializeDetailedStatusCodesMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</DetailedStatusCodesMetrics>");
    }
    if (value.prefix_level) |v| {
        try buf.appendSlice(alloc, "<PrefixLevel>");
        try serializePrefixLevel(alloc, buf, v);
        try buf.appendSlice(alloc, "</PrefixLevel>");
    }
}

pub fn serializeCloudWatchMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchMetrics) !void {
    try buf.appendSlice(alloc, "<IsEnabled>");
    try buf.appendSlice(alloc, if (value.is_enabled) "true" else "false");
    try buf.appendSlice(alloc, "</IsEnabled>");
}

pub fn serializeCreateBucketConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CreateBucketConfiguration) !void {
    if (value.location_constraint) |v| {
        try buf.appendSlice(alloc, "<LocationConstraint>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</LocationConstraint>");
    }
}

pub fn serializeCreateMultiRegionAccessPointInput(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CreateMultiRegionAccessPointInput) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.public_access_block) |v| {
        try buf.appendSlice(alloc, "<PublicAccessBlock>");
        try serializePublicAccessBlockConfiguration(alloc, buf, v);
        try buf.appendSlice(alloc, "</PublicAccessBlock>");
    }
    try buf.appendSlice(alloc, "<Regions>");
    try serializeRegionCreationList(alloc, buf, value.regions, "Region");
    try buf.appendSlice(alloc, "</Regions>");
}

pub fn serializeDeleteMarkerReplication(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeleteMarkerReplication) !void {
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeDeleteMultiRegionAccessPointInput(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeleteMultiRegionAccessPointInput) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
}

pub fn serializeDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Destination) !void {
    if (value.access_control_translation) |v| {
        try buf.appendSlice(alloc, "<AccessControlTranslation>");
        try serializeAccessControlTranslation(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccessControlTranslation>");
    }
    if (value.account) |v| {
        try buf.appendSlice(alloc, "<Account>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Account>");
    }
    try buf.appendSlice(alloc, "<Bucket>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.bucket);
    try buf.appendSlice(alloc, "</Bucket>");
    if (value.encryption_configuration) |v| {
        try buf.appendSlice(alloc, "<EncryptionConfiguration>");
        try serializeEncryptionConfiguration(alloc, buf, v);
        try buf.appendSlice(alloc, "</EncryptionConfiguration>");
    }
    if (value.metrics) |v| {
        try buf.appendSlice(alloc, "<Metrics>");
        try serializeMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</Metrics>");
    }
    if (value.replication_time) |v| {
        try buf.appendSlice(alloc, "<ReplicationTime>");
        try serializeReplicationTime(alloc, buf, v);
        try buf.appendSlice(alloc, "</ReplicationTime>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(alloc, "<StorageClass>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</StorageClass>");
    }
}

pub fn serializeDetailedStatusCodesMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DetailedStatusCodesMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(alloc, "<IsEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsEnabled>");
    }
}

pub fn serializeEncryptionConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EncryptionConfiguration) !void {
    if (value.replica_kms_key_id) |v| {
        try buf.appendSlice(alloc, "<ReplicaKmsKeyID>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ReplicaKmsKeyID>");
    }
}

pub fn serializeExclude(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Exclude) !void {
    if (value.buckets) |v| {
        try buf.appendSlice(alloc, "<Buckets>");
        try serializeBuckets(alloc, buf, v, "Arn");
        try buf.appendSlice(alloc, "</Buckets>");
    }
    if (value.regions) |v| {
        try buf.appendSlice(alloc, "<Regions>");
        try serializeRegions(alloc, buf, v, "Region");
        try buf.appendSlice(alloc, "</Regions>");
    }
}

pub fn serializeExistingObjectReplication(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ExistingObjectReplication) !void {
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeGrantee(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Grantee) !void {
    if (value.grantee_identifier) |v| {
        try buf.appendSlice(alloc, "<GranteeIdentifier>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</GranteeIdentifier>");
    }
    if (value.grantee_type) |v| {
        try buf.appendSlice(alloc, "<GranteeType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</GranteeType>");
    }
}

pub fn serializeInclude(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Include) !void {
    if (value.buckets) |v| {
        try buf.appendSlice(alloc, "<Buckets>");
        try serializeBuckets(alloc, buf, v, "Arn");
        try buf.appendSlice(alloc, "</Buckets>");
    }
    if (value.regions) |v| {
        try buf.appendSlice(alloc, "<Regions>");
        try serializeRegions(alloc, buf, v, "Region");
        try buf.appendSlice(alloc, "</Regions>");
    }
}

pub fn serializeJobManifest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobManifest) !void {
    try buf.appendSlice(alloc, "<Location>");
    try serializeJobManifestLocation(alloc, buf, value.location);
    try buf.appendSlice(alloc, "</Location>");
    try buf.appendSlice(alloc, "<Spec>");
    try serializeJobManifestSpec(alloc, buf, value.spec);
    try buf.appendSlice(alloc, "</Spec>");
}

pub fn serializeJobManifestLocation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobManifestLocation) !void {
    try buf.appendSlice(alloc, "<ETag>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.e_tag);
    try buf.appendSlice(alloc, "</ETag>");
    try buf.appendSlice(alloc, "<ObjectArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.object_arn);
    try buf.appendSlice(alloc, "</ObjectArn>");
    if (value.object_version_id) |v| {
        try buf.appendSlice(alloc, "<ObjectVersionId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ObjectVersionId>");
    }
}

pub fn serializeJobManifestSpec(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobManifestSpec) !void {
    if (value.fields) |v| {
        try buf.appendSlice(alloc, "<Fields>");
        try serializeJobManifestFieldList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Fields>");
    }
    try buf.appendSlice(alloc, "<Format>");
    try buf.appendSlice(alloc, @tagName(value.format));
    try buf.appendSlice(alloc, "</Format>");
}

pub fn serializeJobOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobOperation) !void {
    if (value.lambda_invoke) |v| {
        try buf.appendSlice(alloc, "<LambdaInvoke>");
        try serializeLambdaInvokeOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</LambdaInvoke>");
    }
    if (value.s3_compute_object_checksum) |v| {
        try buf.appendSlice(alloc, "<S3ComputeObjectChecksum>");
        try serializeS3ComputeObjectChecksumOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3ComputeObjectChecksum>");
    }
    if (value.s3_delete_object_tagging) |v| {
        try buf.appendSlice(alloc, "<S3DeleteObjectTagging>");
        try serializeS3DeleteObjectTaggingOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3DeleteObjectTagging>");
    }
    if (value.s3_initiate_restore_object) |v| {
        try buf.appendSlice(alloc, "<S3InitiateRestoreObject>");
        try serializeS3InitiateRestoreObjectOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3InitiateRestoreObject>");
    }
    if (value.s3_put_object_acl) |v| {
        try buf.appendSlice(alloc, "<S3PutObjectAcl>");
        try serializeS3SetObjectAclOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3PutObjectAcl>");
    }
    if (value.s3_put_object_copy) |v| {
        try buf.appendSlice(alloc, "<S3PutObjectCopy>");
        try serializeS3CopyObjectOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3PutObjectCopy>");
    }
    if (value.s3_put_object_legal_hold) |v| {
        try buf.appendSlice(alloc, "<S3PutObjectLegalHold>");
        try serializeS3SetObjectLegalHoldOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3PutObjectLegalHold>");
    }
    if (value.s3_put_object_retention) |v| {
        try buf.appendSlice(alloc, "<S3PutObjectRetention>");
        try serializeS3SetObjectRetentionOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3PutObjectRetention>");
    }
    if (value.s3_put_object_tagging) |v| {
        try buf.appendSlice(alloc, "<S3PutObjectTagging>");
        try serializeS3SetObjectTaggingOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3PutObjectTagging>");
    }
    if (value.s3_replicate_object) |v| {
        try buf.appendSlice(alloc, "<S3ReplicateObject>");
        try serializeS3ReplicateObjectOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3ReplicateObject>");
    }
    if (value.s3_update_object_encryption) |v| {
        try buf.appendSlice(alloc, "<S3UpdateObjectEncryption>");
        try serializeS3UpdateObjectEncryptionOperation(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3UpdateObjectEncryption>");
    }
}

pub fn serializeJobReport(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobReport) !void {
    if (value.bucket) |v| {
        try buf.appendSlice(alloc, "<Bucket>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Bucket>");
    }
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.expected_bucket_owner) |v| {
        try buf.appendSlice(alloc, "<ExpectedBucketOwner>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ExpectedBucketOwner>");
    }
    if (value.format) |v| {
        try buf.appendSlice(alloc, "<Format>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Format>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
    if (value.report_scope) |v| {
        try buf.appendSlice(alloc, "<ReportScope>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ReportScope>");
    }
}

pub fn serializeLambdaInvokeOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaInvokeOperation) !void {
    if (value.function_arn) |v| {
        try buf.appendSlice(alloc, "<FunctionArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</FunctionArn>");
    }
    if (value.invocation_schema_version) |v| {
        try buf.appendSlice(alloc, "<InvocationSchemaVersion>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</InvocationSchemaVersion>");
    }
    if (value.user_arguments) |v| {
        try buf.appendSlice(alloc, "<UserArguments>");
        try serializeUserArguments(alloc, buf, v, "entry");
        try buf.appendSlice(alloc, "</UserArguments>");
    }
}

pub fn serializeLifecycleConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleConfiguration) !void {
    if (value.rules) |v| {
        try buf.appendSlice(alloc, "<Rules>");
        try serializeLifecycleRules(alloc, buf, v, "Rule");
        try buf.appendSlice(alloc, "</Rules>");
    }
}

pub fn serializeLifecycleExpiration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleExpiration) !void {
    if (value.date) |v| {
        try buf.appendSlice(alloc, "<Date>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</Date>");
    }
    if (value.days) |v| {
        try buf.appendSlice(alloc, "<Days>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Days>");
    }
    if (value.expired_object_delete_marker) |v| {
        try buf.appendSlice(alloc, "<ExpiredObjectDeleteMarker>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ExpiredObjectDeleteMarker>");
    }
}

pub fn serializeLifecycleRule(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleRule) !void {
    if (value.abort_incomplete_multipart_upload) |v| {
        try buf.appendSlice(alloc, "<AbortIncompleteMultipartUpload>");
        try serializeAbortIncompleteMultipartUpload(alloc, buf, v);
        try buf.appendSlice(alloc, "</AbortIncompleteMultipartUpload>");
    }
    if (value.expiration) |v| {
        try buf.appendSlice(alloc, "<Expiration>");
        try serializeLifecycleExpiration(alloc, buf, v);
        try buf.appendSlice(alloc, "</Expiration>");
    }
    if (value.filter) |v| {
        try buf.appendSlice(alloc, "<Filter>");
        try serializeLifecycleRuleFilter(alloc, buf, v);
        try buf.appendSlice(alloc, "</Filter>");
    }
    if (value.id) |v| {
        try buf.appendSlice(alloc, "<ID>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ID>");
    }
    if (value.noncurrent_version_expiration) |v| {
        try buf.appendSlice(alloc, "<NoncurrentVersionExpiration>");
        try serializeNoncurrentVersionExpiration(alloc, buf, v);
        try buf.appendSlice(alloc, "</NoncurrentVersionExpiration>");
    }
    if (value.noncurrent_version_transitions) |v| {
        try buf.appendSlice(alloc, "<NoncurrentVersionTransitions>");
        try serializeNoncurrentVersionTransitionList(alloc, buf, v, "NoncurrentVersionTransition");
        try buf.appendSlice(alloc, "</NoncurrentVersionTransitions>");
    }
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
    if (value.transitions) |v| {
        try buf.appendSlice(alloc, "<Transitions>");
        try serializeTransitionList(alloc, buf, v, "Transition");
        try buf.appendSlice(alloc, "</Transitions>");
    }
}

pub fn serializeLifecycleRuleAndOperator(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleRuleAndOperator) !void {
    if (value.object_size_greater_than) |v| {
        try buf.appendSlice(alloc, "<ObjectSizeGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ObjectSizeGreaterThan>");
    }
    if (value.object_size_less_than) |v| {
        try buf.appendSlice(alloc, "<ObjectSizeLessThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ObjectSizeLessThan>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
    if (value.tags) |v| {
        try buf.appendSlice(alloc, "<Tags>");
        try serializeS3TagSet(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Tags>");
    }
}

pub fn serializeLifecycleRuleFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleRuleFilter) !void {
    if (value.@"and") |v| {
        try buf.appendSlice(alloc, "<And>");
        try serializeLifecycleRuleAndOperator(alloc, buf, v);
        try buf.appendSlice(alloc, "</And>");
    }
    if (value.object_size_greater_than) |v| {
        try buf.appendSlice(alloc, "<ObjectSizeGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ObjectSizeGreaterThan>");
    }
    if (value.object_size_less_than) |v| {
        try buf.appendSlice(alloc, "<ObjectSizeLessThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ObjectSizeLessThan>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
    if (value.tag) |v| {
        try buf.appendSlice(alloc, "<Tag>");
        try serializeS3Tag(alloc, buf, v);
        try buf.appendSlice(alloc, "</Tag>");
    }
}

pub fn serializeMatchObjectAge(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MatchObjectAge) !void {
    if (value.days_greater_than) |v| {
        try buf.appendSlice(alloc, "<DaysGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DaysGreaterThan>");
    }
    if (value.days_less_than) |v| {
        try buf.appendSlice(alloc, "<DaysLessThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DaysLessThan>");
    }
}

pub fn serializeMatchObjectSize(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MatchObjectSize) !void {
    if (value.bytes_greater_than) |v| {
        try buf.appendSlice(alloc, "<BytesGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</BytesGreaterThan>");
    }
    if (value.bytes_less_than) |v| {
        try buf.appendSlice(alloc, "<BytesLessThan>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</BytesLessThan>");
    }
}

pub fn serializeMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Metrics) !void {
    if (value.event_threshold) |v| {
        try buf.appendSlice(alloc, "<EventThreshold>");
        try serializeReplicationTimeValue(alloc, buf, v);
        try buf.appendSlice(alloc, "</EventThreshold>");
    }
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeMultiRegionAccessPointRoute(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MultiRegionAccessPointRoute) !void {
    if (value.bucket) |v| {
        try buf.appendSlice(alloc, "<Bucket>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Bucket>");
    }
    if (value.region) |v| {
        try buf.appendSlice(alloc, "<Region>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Region>");
    }
    try buf.appendSlice(alloc, "<TrafficDialPercentage>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.traffic_dial_percentage}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</TrafficDialPercentage>");
}

pub fn serializeNoncurrentVersionExpiration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: NoncurrentVersionExpiration) !void {
    if (value.newer_noncurrent_versions) |v| {
        try buf.appendSlice(alloc, "<NewerNoncurrentVersions>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</NewerNoncurrentVersions>");
    }
    if (value.noncurrent_days) |v| {
        try buf.appendSlice(alloc, "<NoncurrentDays>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</NoncurrentDays>");
    }
}

pub fn serializeNoncurrentVersionTransition(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: NoncurrentVersionTransition) !void {
    if (value.noncurrent_days) |v| {
        try buf.appendSlice(alloc, "<NoncurrentDays>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</NoncurrentDays>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(alloc, "<StorageClass>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</StorageClass>");
    }
}

pub fn serializeObjectEncryption(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectEncryption) !void {
    if (value.ssekms) |v| {
        try buf.appendSlice(alloc, "<SSE-KMS>");
        try serializeS3UpdateObjectEncryptionSSEKMS(alloc, buf, v);
        try buf.appendSlice(alloc, "</SSE-KMS>");
    }
}

pub fn serializeObjectLambdaConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLambdaConfiguration) !void {
    if (value.allowed_features) |v| {
        try buf.appendSlice(alloc, "<AllowedFeatures>");
        try serializeObjectLambdaAllowedFeaturesList(alloc, buf, v, "AllowedFeature");
        try buf.appendSlice(alloc, "</AllowedFeatures>");
    }
    if (value.cloud_watch_metrics_enabled) |v| {
        try buf.appendSlice(alloc, "<CloudWatchMetricsEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</CloudWatchMetricsEnabled>");
    }
    try buf.appendSlice(alloc, "<SupportingAccessPoint>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.supporting_access_point);
    try buf.appendSlice(alloc, "</SupportingAccessPoint>");
    try buf.appendSlice(alloc, "<TransformationConfigurations>");
    try serializeObjectLambdaTransformationConfigurationsList(alloc, buf, value.transformation_configurations, "TransformationConfiguration");
    try buf.appendSlice(alloc, "</TransformationConfigurations>");
}

pub fn serializeObjectLambdaTransformationConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLambdaTransformationConfiguration) !void {
    try buf.appendSlice(alloc, "<Actions>");
    try serializeObjectLambdaTransformationConfigurationActionsList(alloc, buf, value.actions, "Action");
    try buf.appendSlice(alloc, "</Actions>");
}

pub fn serializePrefixLevel(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PrefixLevel) !void {
    try buf.appendSlice(alloc, "<StorageMetrics>");
    try serializePrefixLevelStorageMetrics(alloc, buf, value.storage_metrics);
    try buf.appendSlice(alloc, "</StorageMetrics>");
}

pub fn serializePrefixLevelStorageMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PrefixLevelStorageMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(alloc, "<IsEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsEnabled>");
    }
    if (value.selection_criteria) |v| {
        try buf.appendSlice(alloc, "<SelectionCriteria>");
        try serializeSelectionCriteria(alloc, buf, v);
        try buf.appendSlice(alloc, "</SelectionCriteria>");
    }
}

pub fn serializePublicAccessBlockConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PublicAccessBlockConfiguration) !void {
    if (value.block_public_acls) |v| {
        try buf.appendSlice(alloc, "<BlockPublicAcls>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</BlockPublicAcls>");
    }
    if (value.block_public_policy) |v| {
        try buf.appendSlice(alloc, "<BlockPublicPolicy>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</BlockPublicPolicy>");
    }
    if (value.ignore_public_acls) |v| {
        try buf.appendSlice(alloc, "<IgnorePublicAcls>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IgnorePublicAcls>");
    }
    if (value.restrict_public_buckets) |v| {
        try buf.appendSlice(alloc, "<RestrictPublicBuckets>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</RestrictPublicBuckets>");
    }
}

pub fn serializePutMultiRegionAccessPointPolicyInput(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PutMultiRegionAccessPointPolicyInput) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Policy>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.policy);
    try buf.appendSlice(alloc, "</Policy>");
}

pub fn serializeRegion(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Region) !void {
    try buf.appendSlice(alloc, "<Bucket>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.bucket);
    try buf.appendSlice(alloc, "</Bucket>");
    if (value.bucket_account_id) |v| {
        try buf.appendSlice(alloc, "<BucketAccountId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</BucketAccountId>");
    }
}

pub fn serializeReplicaModifications(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicaModifications) !void {
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeReplicationConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationConfiguration) !void {
    try buf.appendSlice(alloc, "<Role>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.role);
    try buf.appendSlice(alloc, "</Role>");
    try buf.appendSlice(alloc, "<Rules>");
    try serializeReplicationRules(alloc, buf, value.rules, "Rule");
    try buf.appendSlice(alloc, "</Rules>");
}

pub fn serializeReplicationRule(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationRule) !void {
    try buf.appendSlice(alloc, "<Bucket>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.bucket);
    try buf.appendSlice(alloc, "</Bucket>");
    if (value.delete_marker_replication) |v| {
        try buf.appendSlice(alloc, "<DeleteMarkerReplication>");
        try serializeDeleteMarkerReplication(alloc, buf, v);
        try buf.appendSlice(alloc, "</DeleteMarkerReplication>");
    }
    try buf.appendSlice(alloc, "<Destination>");
    try serializeDestination(alloc, buf, value.destination);
    try buf.appendSlice(alloc, "</Destination>");
    if (value.existing_object_replication) |v| {
        try buf.appendSlice(alloc, "<ExistingObjectReplication>");
        try serializeExistingObjectReplication(alloc, buf, v);
        try buf.appendSlice(alloc, "</ExistingObjectReplication>");
    }
    if (value.filter) |v| {
        try buf.appendSlice(alloc, "<Filter>");
        try serializeReplicationRuleFilter(alloc, buf, v);
        try buf.appendSlice(alloc, "</Filter>");
    }
    if (value.id) |v| {
        try buf.appendSlice(alloc, "<ID>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ID>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
    if (value.priority) |v| {
        try buf.appendSlice(alloc, "<Priority>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Priority>");
    }
    if (value.source_selection_criteria) |v| {
        try buf.appendSlice(alloc, "<SourceSelectionCriteria>");
        try serializeSourceSelectionCriteria(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceSelectionCriteria>");
    }
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeReplicationRuleAndOperator(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationRuleAndOperator) !void {
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
    if (value.tags) |v| {
        try buf.appendSlice(alloc, "<Tags>");
        try serializeS3TagSet(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Tags>");
    }
}

pub fn serializeReplicationRuleFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationRuleFilter) !void {
    if (value.@"and") |v| {
        try buf.appendSlice(alloc, "<And>");
        try serializeReplicationRuleAndOperator(alloc, buf, v);
        try buf.appendSlice(alloc, "</And>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
    if (value.tag) |v| {
        try buf.appendSlice(alloc, "<Tag>");
        try serializeS3Tag(alloc, buf, v);
        try buf.appendSlice(alloc, "</Tag>");
    }
}

pub fn serializeReplicationTime(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationTime) !void {
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
    try buf.appendSlice(alloc, "<Time>");
    try serializeReplicationTimeValue(alloc, buf, value.time);
    try buf.appendSlice(alloc, "</Time>");
}

pub fn serializeReplicationTimeValue(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationTimeValue) !void {
    if (value.minutes) |v| {
        try buf.appendSlice(alloc, "<Minutes>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Minutes>");
    }
}

pub fn serializeS3AccessControlList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3AccessControlList) !void {
    if (value.grants) |v| {
        try buf.appendSlice(alloc, "<Grants>");
        try serializeS3GrantList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Grants>");
    }
    try buf.appendSlice(alloc, "<Owner>");
    try serializeS3ObjectOwner(alloc, buf, value.owner);
    try buf.appendSlice(alloc, "</Owner>");
}

pub fn serializeS3AccessControlPolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3AccessControlPolicy) !void {
    if (value.access_control_list) |v| {
        try buf.appendSlice(alloc, "<AccessControlList>");
        try serializeS3AccessControlList(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccessControlList>");
    }
    if (value.canned_access_control_list) |v| {
        try buf.appendSlice(alloc, "<CannedAccessControlList>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</CannedAccessControlList>");
    }
}

pub fn serializeS3BucketDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3BucketDestination) !void {
    try buf.appendSlice(alloc, "<AccountId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.account_id);
    try buf.appendSlice(alloc, "</AccountId>");
    try buf.appendSlice(alloc, "<Arn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.arn);
    try buf.appendSlice(alloc, "</Arn>");
    if (value.encryption) |v| {
        try buf.appendSlice(alloc, "<Encryption>");
        try serializeStorageLensDataExportEncryption(alloc, buf, v);
        try buf.appendSlice(alloc, "</Encryption>");
    }
    try buf.appendSlice(alloc, "<Format>");
    try buf.appendSlice(alloc, @tagName(value.format));
    try buf.appendSlice(alloc, "</Format>");
    try buf.appendSlice(alloc, "<OutputSchemaVersion>");
    try buf.appendSlice(alloc, @tagName(value.output_schema_version));
    try buf.appendSlice(alloc, "</OutputSchemaVersion>");
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
}

pub fn serializeS3ComputeObjectChecksumOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ComputeObjectChecksumOperation) !void {
    if (value.checksum_algorithm) |v| {
        try buf.appendSlice(alloc, "<ChecksumAlgorithm>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ChecksumAlgorithm>");
    }
    if (value.checksum_type) |v| {
        try buf.appendSlice(alloc, "<ChecksumType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ChecksumType>");
    }
}

pub fn serializeS3CopyObjectOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3CopyObjectOperation) !void {
    if (value.access_control_grants) |v| {
        try buf.appendSlice(alloc, "<AccessControlGrants>");
        try serializeS3GrantList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</AccessControlGrants>");
    }
    if (value.bucket_key_enabled) |v| {
        try buf.appendSlice(alloc, "<BucketKeyEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</BucketKeyEnabled>");
    }
    if (value.canned_access_control_list) |v| {
        try buf.appendSlice(alloc, "<CannedAccessControlList>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</CannedAccessControlList>");
    }
    if (value.checksum_algorithm) |v| {
        try buf.appendSlice(alloc, "<ChecksumAlgorithm>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ChecksumAlgorithm>");
    }
    if (value.metadata_directive) |v| {
        try buf.appendSlice(alloc, "<MetadataDirective>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</MetadataDirective>");
    }
    if (value.modified_since_constraint) |v| {
        try buf.appendSlice(alloc, "<ModifiedSinceConstraint>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</ModifiedSinceConstraint>");
    }
    if (value.new_object_metadata) |v| {
        try buf.appendSlice(alloc, "<NewObjectMetadata>");
        try serializeS3ObjectMetadata(alloc, buf, v);
        try buf.appendSlice(alloc, "</NewObjectMetadata>");
    }
    if (value.new_object_tagging) |v| {
        try buf.appendSlice(alloc, "<NewObjectTagging>");
        try serializeS3TagSet(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</NewObjectTagging>");
    }
    if (value.object_lock_legal_hold_status) |v| {
        try buf.appendSlice(alloc, "<ObjectLockLegalHoldStatus>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ObjectLockLegalHoldStatus>");
    }
    if (value.object_lock_mode) |v| {
        try buf.appendSlice(alloc, "<ObjectLockMode>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ObjectLockMode>");
    }
    if (value.object_lock_retain_until_date) |v| {
        try buf.appendSlice(alloc, "<ObjectLockRetainUntilDate>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</ObjectLockRetainUntilDate>");
    }
    if (value.redirect_location) |v| {
        try buf.appendSlice(alloc, "<RedirectLocation>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RedirectLocation>");
    }
    if (value.requester_pays) |v| {
        try buf.appendSlice(alloc, "<RequesterPays>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</RequesterPays>");
    }
    if (value.sse_aws_kms_key_id) |v| {
        try buf.appendSlice(alloc, "<SSEAwsKmsKeyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SSEAwsKmsKeyId>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(alloc, "<StorageClass>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</StorageClass>");
    }
    if (value.target_key_prefix) |v| {
        try buf.appendSlice(alloc, "<TargetKeyPrefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TargetKeyPrefix>");
    }
    if (value.target_resource) |v| {
        try buf.appendSlice(alloc, "<TargetResource>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TargetResource>");
    }
    if (value.un_modified_since_constraint) |v| {
        try buf.appendSlice(alloc, "<UnModifiedSinceConstraint>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</UnModifiedSinceConstraint>");
    }
}

pub fn serializeS3DeleteObjectTaggingOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3DeleteObjectTaggingOperation) !void {
    _ = alloc;
    _ = buf;
    _ = value;
}

pub fn serializeS3Grant(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Grant) !void {
    if (value.grantee) |v| {
        try buf.appendSlice(alloc, "<Grantee>");
        try serializeS3Grantee(alloc, buf, v);
        try buf.appendSlice(alloc, "</Grantee>");
    }
    if (value.permission) |v| {
        try buf.appendSlice(alloc, "<Permission>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Permission>");
    }
}

pub fn serializeS3Grantee(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Grantee) !void {
    if (value.display_name) |v| {
        try buf.appendSlice(alloc, "<DisplayName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DisplayName>");
    }
    if (value.identifier) |v| {
        try buf.appendSlice(alloc, "<Identifier>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Identifier>");
    }
    if (value.type_identifier) |v| {
        try buf.appendSlice(alloc, "<TypeIdentifier>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</TypeIdentifier>");
    }
}

pub fn serializeS3InitiateRestoreObjectOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3InitiateRestoreObjectOperation) !void {
    if (value.expiration_in_days) |v| {
        try buf.appendSlice(alloc, "<ExpirationInDays>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ExpirationInDays>");
    }
    if (value.glacier_job_tier) |v| {
        try buf.appendSlice(alloc, "<GlacierJobTier>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</GlacierJobTier>");
    }
}

pub fn serializeS3ObjectLockLegalHold(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ObjectLockLegalHold) !void {
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeS3ObjectMetadata(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ObjectMetadata) !void {
    if (value.cache_control) |v| {
        try buf.appendSlice(alloc, "<CacheControl>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</CacheControl>");
    }
    if (value.content_disposition) |v| {
        try buf.appendSlice(alloc, "<ContentDisposition>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentDisposition>");
    }
    if (value.content_encoding) |v| {
        try buf.appendSlice(alloc, "<ContentEncoding>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentEncoding>");
    }
    if (value.content_language) |v| {
        try buf.appendSlice(alloc, "<ContentLanguage>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentLanguage>");
    }
    if (value.content_length) |v| {
        try buf.appendSlice(alloc, "<ContentLength>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ContentLength>");
    }
    if (value.content_md5) |v| {
        try buf.appendSlice(alloc, "<ContentMD5>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentMD5>");
    }
    if (value.content_type) |v| {
        try buf.appendSlice(alloc, "<ContentType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentType>");
    }
    if (value.http_expires_date) |v| {
        try buf.appendSlice(alloc, "<HttpExpiresDate>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</HttpExpiresDate>");
    }
    if (value.requester_charged) |v| {
        try buf.appendSlice(alloc, "<RequesterCharged>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</RequesterCharged>");
    }
    if (value.sse_algorithm) |v| {
        try buf.appendSlice(alloc, "<SSEAlgorithm>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</SSEAlgorithm>");
    }
    if (value.user_metadata) |v| {
        try buf.appendSlice(alloc, "<UserMetadata>");
        try serializeS3UserMetadata(alloc, buf, v, "entry");
        try buf.appendSlice(alloc, "</UserMetadata>");
    }
}

pub fn serializeS3ObjectOwner(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ObjectOwner) !void {
    if (value.display_name) |v| {
        try buf.appendSlice(alloc, "<DisplayName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DisplayName>");
    }
    if (value.id) |v| {
        try buf.appendSlice(alloc, "<ID>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ID>");
    }
}

pub fn serializeS3ReplicateObjectOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ReplicateObjectOperation) !void {
    _ = alloc;
    _ = buf;
    _ = value;
}

pub fn serializeS3Retention(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Retention) !void {
    if (value.mode) |v| {
        try buf.appendSlice(alloc, "<Mode>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Mode>");
    }
    if (value.retain_until_date) |v| {
        try buf.appendSlice(alloc, "<RetainUntilDate>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</RetainUntilDate>");
    }
}

pub fn serializeS3SetObjectAclOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectAclOperation) !void {
    if (value.access_control_policy) |v| {
        try buf.appendSlice(alloc, "<AccessControlPolicy>");
        try serializeS3AccessControlPolicy(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccessControlPolicy>");
    }
}

pub fn serializeS3SetObjectLegalHoldOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectLegalHoldOperation) !void {
    try buf.appendSlice(alloc, "<LegalHold>");
    try serializeS3ObjectLockLegalHold(alloc, buf, value.legal_hold);
    try buf.appendSlice(alloc, "</LegalHold>");
}

pub fn serializeS3SetObjectRetentionOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectRetentionOperation) !void {
    if (value.bypass_governance_retention) |v| {
        try buf.appendSlice(alloc, "<BypassGovernanceRetention>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</BypassGovernanceRetention>");
    }
    try buf.appendSlice(alloc, "<Retention>");
    try serializeS3Retention(alloc, buf, value.retention);
    try buf.appendSlice(alloc, "</Retention>");
}

pub fn serializeS3SetObjectTaggingOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectTaggingOperation) !void {
    if (value.tag_set) |v| {
        try buf.appendSlice(alloc, "<TagSet>");
        try serializeS3TagSet(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</TagSet>");
    }
}

pub fn serializeS3Tag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeS3UpdateObjectEncryptionOperation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3UpdateObjectEncryptionOperation) !void {
    if (value.object_encryption) |v| {
        try buf.appendSlice(alloc, "<ObjectEncryption>");
        try serializeObjectEncryption(alloc, buf, v);
        try buf.appendSlice(alloc, "</ObjectEncryption>");
    }
}

pub fn serializeS3UpdateObjectEncryptionSSEKMS(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3UpdateObjectEncryptionSSEKMS) !void {
    if (value.bucket_key_enabled) |v| {
        try buf.appendSlice(alloc, "<BucketKeyEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</BucketKeyEnabled>");
    }
    try buf.appendSlice(alloc, "<KMSKeyArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.kms_key_arn);
    try buf.appendSlice(alloc, "</KMSKeyArn>");
}

pub fn serializeSSEKMS(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SSEKMS) !void {
    try buf.appendSlice(alloc, "<KeyId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key_id);
    try buf.appendSlice(alloc, "</KeyId>");
}

pub fn serializeSSES3(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SSES3) !void {
    _ = alloc;
    _ = buf;
    _ = value;
}

pub fn serializeScope(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Scope) !void {
    if (value.permissions) |v| {
        try buf.appendSlice(alloc, "<Permissions>");
        try serializeScopePermissionList(alloc, buf, v, "Permission");
        try buf.appendSlice(alloc, "</Permissions>");
    }
    if (value.prefixes) |v| {
        try buf.appendSlice(alloc, "<Prefixes>");
        try serializePrefixesList(alloc, buf, v, "Prefix");
        try buf.appendSlice(alloc, "</Prefixes>");
    }
}

pub fn serializeSelectionCriteria(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SelectionCriteria) !void {
    if (value.delimiter) |v| {
        try buf.appendSlice(alloc, "<Delimiter>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Delimiter>");
    }
    if (value.max_depth) |v| {
        try buf.appendSlice(alloc, "<MaxDepth>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxDepth>");
    }
    if (value.min_storage_bytes_percentage) |v| {
        try buf.appendSlice(alloc, "<MinStorageBytesPercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinStorageBytesPercentage>");
    }
}

pub fn serializeSourceSelectionCriteria(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceSelectionCriteria) !void {
    if (value.replica_modifications) |v| {
        try buf.appendSlice(alloc, "<ReplicaModifications>");
        try serializeReplicaModifications(alloc, buf, v);
        try buf.appendSlice(alloc, "</ReplicaModifications>");
    }
    if (value.sse_kms_encrypted_objects) |v| {
        try buf.appendSlice(alloc, "<SseKmsEncryptedObjects>");
        try serializeSseKmsEncryptedObjects(alloc, buf, v);
        try buf.appendSlice(alloc, "</SseKmsEncryptedObjects>");
    }
}

pub fn serializeSseKmsEncryptedObjects(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SseKmsEncryptedObjects) !void {
    try buf.appendSlice(alloc, "<Status>");
    try buf.appendSlice(alloc, @tagName(value.status));
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeStorageLensAwsOrg(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensAwsOrg) !void {
    try buf.appendSlice(alloc, "<Arn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.arn);
    try buf.appendSlice(alloc, "</Arn>");
}

pub fn serializeStorageLensConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensConfiguration) !void {
    try buf.appendSlice(alloc, "<AccountLevel>");
    try serializeAccountLevel(alloc, buf, value.account_level);
    try buf.appendSlice(alloc, "</AccountLevel>");
    if (value.aws_org) |v| {
        try buf.appendSlice(alloc, "<AwsOrg>");
        try serializeStorageLensAwsOrg(alloc, buf, v);
        try buf.appendSlice(alloc, "</AwsOrg>");
    }
    if (value.data_export) |v| {
        try buf.appendSlice(alloc, "<DataExport>");
        try serializeStorageLensDataExport(alloc, buf, v);
        try buf.appendSlice(alloc, "</DataExport>");
    }
    if (value.exclude) |v| {
        try buf.appendSlice(alloc, "<Exclude>");
        try serializeExclude(alloc, buf, v);
        try buf.appendSlice(alloc, "</Exclude>");
    }
    if (value.expanded_prefixes_data_export) |v| {
        try buf.appendSlice(alloc, "<ExpandedPrefixesDataExport>");
        try serializeStorageLensExpandedPrefixesDataExport(alloc, buf, v);
        try buf.appendSlice(alloc, "</ExpandedPrefixesDataExport>");
    }
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
    if (value.include) |v| {
        try buf.appendSlice(alloc, "<Include>");
        try serializeInclude(alloc, buf, v);
        try buf.appendSlice(alloc, "</Include>");
    }
    try buf.appendSlice(alloc, "<IsEnabled>");
    try buf.appendSlice(alloc, if (value.is_enabled) "true" else "false");
    try buf.appendSlice(alloc, "</IsEnabled>");
    if (value.prefix_delimiter) |v| {
        try buf.appendSlice(alloc, "<PrefixDelimiter>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</PrefixDelimiter>");
    }
    if (value.storage_lens_arn) |v| {
        try buf.appendSlice(alloc, "<StorageLensArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</StorageLensArn>");
    }
}

pub fn serializeStorageLensDataExport(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensDataExport) !void {
    if (value.cloud_watch_metrics) |v| {
        try buf.appendSlice(alloc, "<CloudWatchMetrics>");
        try serializeCloudWatchMetrics(alloc, buf, v);
        try buf.appendSlice(alloc, "</CloudWatchMetrics>");
    }
    if (value.s3_bucket_destination) |v| {
        try buf.appendSlice(alloc, "<S3BucketDestination>");
        try serializeS3BucketDestination(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3BucketDestination>");
    }
    if (value.storage_lens_table_destination) |v| {
        try buf.appendSlice(alloc, "<StorageLensTableDestination>");
        try serializeStorageLensTableDestination(alloc, buf, v);
        try buf.appendSlice(alloc, "</StorageLensTableDestination>");
    }
}

pub fn serializeStorageLensDataExportEncryption(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensDataExportEncryption) !void {
    if (value.ssekms) |v| {
        try buf.appendSlice(alloc, "<SSE-KMS>");
        try serializeSSEKMS(alloc, buf, v);
        try buf.appendSlice(alloc, "</SSE-KMS>");
    }
    if (value.sses3) |v| {
        try buf.appendSlice(alloc, "<SSE-S3>");
        try serializeSSES3(alloc, buf, v);
        try buf.appendSlice(alloc, "</SSE-S3>");
    }
}

pub fn serializeStorageLensExpandedPrefixesDataExport(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensExpandedPrefixesDataExport) !void {
    if (value.s3_bucket_destination) |v| {
        try buf.appendSlice(alloc, "<S3BucketDestination>");
        try serializeS3BucketDestination(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3BucketDestination>");
    }
    if (value.storage_lens_table_destination) |v| {
        try buf.appendSlice(alloc, "<StorageLensTableDestination>");
        try serializeStorageLensTableDestination(alloc, buf, v);
        try buf.appendSlice(alloc, "</StorageLensTableDestination>");
    }
}

pub fn serializeStorageLensGroup(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroup) !void {
    try buf.appendSlice(alloc, "<Filter>");
    try serializeStorageLensGroupFilter(alloc, buf, value.filter);
    try buf.appendSlice(alloc, "</Filter>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.storage_lens_group_arn) |v| {
        try buf.appendSlice(alloc, "<StorageLensGroupArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</StorageLensGroupArn>");
    }
}

pub fn serializeStorageLensGroupAndOperator(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupAndOperator) !void {
    if (value.match_any_prefix) |v| {
        try buf.appendSlice(alloc, "<MatchAnyPrefix>");
        try serializeMatchAnyPrefix(alloc, buf, v, "Prefix");
        try buf.appendSlice(alloc, "</MatchAnyPrefix>");
    }
    if (value.match_any_suffix) |v| {
        try buf.appendSlice(alloc, "<MatchAnySuffix>");
        try serializeMatchAnySuffix(alloc, buf, v, "Suffix");
        try buf.appendSlice(alloc, "</MatchAnySuffix>");
    }
    if (value.match_any_tag) |v| {
        try buf.appendSlice(alloc, "<MatchAnyTag>");
        try serializeMatchAnyTag(alloc, buf, v, "Tag");
        try buf.appendSlice(alloc, "</MatchAnyTag>");
    }
    if (value.match_object_age) |v| {
        try buf.appendSlice(alloc, "<MatchObjectAge>");
        try serializeMatchObjectAge(alloc, buf, v);
        try buf.appendSlice(alloc, "</MatchObjectAge>");
    }
    if (value.match_object_size) |v| {
        try buf.appendSlice(alloc, "<MatchObjectSize>");
        try serializeMatchObjectSize(alloc, buf, v);
        try buf.appendSlice(alloc, "</MatchObjectSize>");
    }
}

pub fn serializeStorageLensGroupFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupFilter) !void {
    if (value.@"and") |v| {
        try buf.appendSlice(alloc, "<And>");
        try serializeStorageLensGroupAndOperator(alloc, buf, v);
        try buf.appendSlice(alloc, "</And>");
    }
    if (value.match_any_prefix) |v| {
        try buf.appendSlice(alloc, "<MatchAnyPrefix>");
        try serializeMatchAnyPrefix(alloc, buf, v, "Prefix");
        try buf.appendSlice(alloc, "</MatchAnyPrefix>");
    }
    if (value.match_any_suffix) |v| {
        try buf.appendSlice(alloc, "<MatchAnySuffix>");
        try serializeMatchAnySuffix(alloc, buf, v, "Suffix");
        try buf.appendSlice(alloc, "</MatchAnySuffix>");
    }
    if (value.match_any_tag) |v| {
        try buf.appendSlice(alloc, "<MatchAnyTag>");
        try serializeMatchAnyTag(alloc, buf, v, "Tag");
        try buf.appendSlice(alloc, "</MatchAnyTag>");
    }
    if (value.match_object_age) |v| {
        try buf.appendSlice(alloc, "<MatchObjectAge>");
        try serializeMatchObjectAge(alloc, buf, v);
        try buf.appendSlice(alloc, "</MatchObjectAge>");
    }
    if (value.match_object_size) |v| {
        try buf.appendSlice(alloc, "<MatchObjectSize>");
        try serializeMatchObjectSize(alloc, buf, v);
        try buf.appendSlice(alloc, "</MatchObjectSize>");
    }
    if (value.@"or") |v| {
        try buf.appendSlice(alloc, "<Or>");
        try serializeStorageLensGroupOrOperator(alloc, buf, v);
        try buf.appendSlice(alloc, "</Or>");
    }
}

pub fn serializeStorageLensGroupLevel(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupLevel) !void {
    if (value.selection_criteria) |v| {
        try buf.appendSlice(alloc, "<SelectionCriteria>");
        try serializeStorageLensGroupLevelSelectionCriteria(alloc, buf, v);
        try buf.appendSlice(alloc, "</SelectionCriteria>");
    }
}

pub fn serializeStorageLensGroupLevelSelectionCriteria(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupLevelSelectionCriteria) !void {
    if (value.exclude) |v| {
        try buf.appendSlice(alloc, "<Exclude>");
        try serializeStorageLensGroupLevelExclude(alloc, buf, v, "Arn");
        try buf.appendSlice(alloc, "</Exclude>");
    }
    if (value.include) |v| {
        try buf.appendSlice(alloc, "<Include>");
        try serializeStorageLensGroupLevelInclude(alloc, buf, v, "Arn");
        try buf.appendSlice(alloc, "</Include>");
    }
}

pub fn serializeStorageLensGroupOrOperator(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupOrOperator) !void {
    if (value.match_any_prefix) |v| {
        try buf.appendSlice(alloc, "<MatchAnyPrefix>");
        try serializeMatchAnyPrefix(alloc, buf, v, "Prefix");
        try buf.appendSlice(alloc, "</MatchAnyPrefix>");
    }
    if (value.match_any_suffix) |v| {
        try buf.appendSlice(alloc, "<MatchAnySuffix>");
        try serializeMatchAnySuffix(alloc, buf, v, "Suffix");
        try buf.appendSlice(alloc, "</MatchAnySuffix>");
    }
    if (value.match_any_tag) |v| {
        try buf.appendSlice(alloc, "<MatchAnyTag>");
        try serializeMatchAnyTag(alloc, buf, v, "Tag");
        try buf.appendSlice(alloc, "</MatchAnyTag>");
    }
    if (value.match_object_age) |v| {
        try buf.appendSlice(alloc, "<MatchObjectAge>");
        try serializeMatchObjectAge(alloc, buf, v);
        try buf.appendSlice(alloc, "</MatchObjectAge>");
    }
    if (value.match_object_size) |v| {
        try buf.appendSlice(alloc, "<MatchObjectSize>");
        try serializeMatchObjectSize(alloc, buf, v);
        try buf.appendSlice(alloc, "</MatchObjectSize>");
    }
}

pub fn serializeStorageLensTableDestination(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensTableDestination) !void {
    if (value.encryption) |v| {
        try buf.appendSlice(alloc, "<Encryption>");
        try serializeStorageLensDataExportEncryption(alloc, buf, v);
        try buf.appendSlice(alloc, "</Encryption>");
    }
    try buf.appendSlice(alloc, "<IsEnabled>");
    try buf.appendSlice(alloc, if (value.is_enabled) "true" else "false");
    try buf.appendSlice(alloc, "</IsEnabled>");
}

pub fn serializeStorageLensTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensTag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeTagging(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tagging) !void {
    try buf.appendSlice(alloc, "<TagSet>");
    try serializeS3TagSet(alloc, buf, value.tag_set, "member");
    try buf.appendSlice(alloc, "</TagSet>");
}

pub fn serializeTransition(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Transition) !void {
    if (value.date) |v| {
        try buf.appendSlice(alloc, "<Date>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</Date>");
    }
    if (value.days) |v| {
        try buf.appendSlice(alloc, "<Days>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Days>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(alloc, "<StorageClass>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</StorageClass>");
    }
}

pub fn serializeVersioningConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: VersioningConfiguration) !void {
    if (value.mfa_delete) |v| {
        try buf.appendSlice(alloc, "<MfaDelete>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</MfaDelete>");
    }
    if (value.status) |v| {
        try buf.appendSlice(alloc, "<Status>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Status>");
    }
}

pub fn serializeVpcConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: VpcConfiguration) !void {
    try buf.appendSlice(alloc, "<VpcId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.vpc_id);
    try buf.appendSlice(alloc, "</VpcId>");
}

