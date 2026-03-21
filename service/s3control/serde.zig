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

pub fn deserializeAccessGrantsInstancesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListAccessGrantsInstanceEntry {
    var list: std.ArrayList(ListAccessGrantsInstanceEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListAccessGrantsInstanceEntry(allocator, reader));
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

pub fn deserializeAccessGrantsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListAccessGrantEntry {
    var list: std.ArrayList(ListAccessGrantEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListAccessGrantEntry(allocator, reader));
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

pub fn deserializeAccessGrantsLocationsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListAccessGrantsLocationsEntry {
    var list: std.ArrayList(ListAccessGrantsLocationsEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListAccessGrantsLocationsEntry(allocator, reader));
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

pub fn deserializeAccessPointList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AccessPoint {
    var list: std.ArrayList(AccessPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAccessPoint(allocator, reader));
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

pub fn deserializeBuckets(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCallerAccessGrantsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListCallerAccessGrantsEntry {
    var list: std.ArrayList(ListCallerAccessGrantsEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListCallerAccessGrantsEntry(allocator, reader));
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

pub fn deserializeJobFailureList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const JobFailure {
    var list: std.ArrayList(JobFailure) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeJobFailure(allocator, reader));
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

pub fn deserializeJobListDescriptorList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const JobListDescriptor {
    var list: std.ArrayList(JobListDescriptor) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeJobListDescriptor(allocator, reader));
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

pub fn deserializeJobManifestFieldList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const JobManifestFieldName {
    var list: std.ArrayList(JobManifestFieldName) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (JobManifestFieldName.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeMatchAnyPrefix(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeMatchAnySuffix(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeMatchAnyTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const S3Tag {
    var list: std.ArrayList(S3Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeS3Tag(allocator, reader));
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

pub fn deserializeMultiRegionAccessPointRegionalResponseList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MultiRegionAccessPointRegionalResponse {
    var list: std.ArrayList(MultiRegionAccessPointRegionalResponse) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMultiRegionAccessPointRegionalResponse(allocator, reader));
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

pub fn deserializeMultiRegionAccessPointReportList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MultiRegionAccessPointReport {
    var list: std.ArrayList(MultiRegionAccessPointReport) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMultiRegionAccessPointReport(allocator, reader));
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

pub fn deserializeObjectLambdaAccessPointList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ObjectLambdaAccessPoint {
    var list: std.ArrayList(ObjectLambdaAccessPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeObjectLambdaAccessPoint(allocator, reader));
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

pub fn deserializeObjectLambdaAllowedFeaturesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ObjectLambdaAllowedFeature {
    var list: std.ArrayList(ObjectLambdaAllowedFeature) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (ObjectLambdaAllowedFeature.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeObjectLambdaTransformationConfigurationActionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ObjectLambdaTransformationConfigurationAction {
    var list: std.ArrayList(ObjectLambdaTransformationConfigurationAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (ObjectLambdaTransformationConfigurationAction.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeObjectLambdaTransformationConfigurationsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ObjectLambdaTransformationConfiguration {
    var list: std.ArrayList(ObjectLambdaTransformationConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeObjectLambdaTransformationConfiguration(allocator, reader));
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

pub fn deserializePrefixesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRegionCreationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Region {
    var list: std.ArrayList(Region) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRegion(allocator, reader));
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

pub fn deserializeRegionReportList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RegionReport {
    var list: std.ArrayList(RegionReport) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRegionReport(allocator, reader));
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

pub fn deserializeRegionalBucketList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RegionalBucket {
    var list: std.ArrayList(RegionalBucket) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRegionalBucket(allocator, reader));
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

pub fn deserializeRegions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRouteList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MultiRegionAccessPointRoute {
    var list: std.ArrayList(MultiRegionAccessPointRoute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMultiRegionAccessPointRoute(allocator, reader));
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

pub fn deserializeS3GrantList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const S3Grant {
    var list: std.ArrayList(S3Grant) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeS3Grant(allocator, reader));
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

pub fn deserializeS3TagSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const S3Tag {
    var list: std.ArrayList(S3Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeS3Tag(allocator, reader));
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

pub fn deserializeScopePermissionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ScopePermission {
    var list: std.ArrayList(ScopePermission) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (ScopePermission.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeStorageLensConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListStorageLensConfigurationEntry {
    var list: std.ArrayList(ListStorageLensConfigurationEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListStorageLensConfigurationEntry(allocator, reader));
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

pub fn deserializeStorageLensGroupLevelExclude(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStorageLensGroupLevelInclude(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStorageLensGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListStorageLensGroupEntry {
    var list: std.ArrayList(ListStorageLensGroupEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListStorageLensGroupEntry(allocator, reader));
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

pub fn deserializeStorageLensTags(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StorageLensTag {
    var list: std.ArrayList(StorageLensTag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStorageLensTag(allocator, reader));
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

pub fn deserializeTagList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
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

pub fn deserializeEndpoints(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeS3UserMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeUserArguments(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeAbortIncompleteMultipartUpload(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AbortIncompleteMultipartUpload {
    _ = allocator;
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

pub fn deserializeAccessGrantsLocationConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessGrantsLocationConfiguration {
    var result: AccessGrantsLocationConfiguration = undefined;
    result.s3_sub_prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3SubPrefix")) {
                    result.s3_sub_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAccessPoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessPoint {
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
                    result.access_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataSourceId")) {
                    result.data_source_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataSourceType")) {
                    result.data_source_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NetworkOrigin")) {
                    result.network_origin = NetworkOrigin.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "VpcConfiguration")) {
                    result.vpc_configuration = try deserializeVpcConfiguration(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAccountLevel(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccountLevel {
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
                    result.activity_metrics = try deserializeActivityMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AdvancedCostOptimizationMetrics")) {
                    result.advanced_cost_optimization_metrics = try deserializeAdvancedCostOptimizationMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AdvancedDataProtectionMetrics")) {
                    result.advanced_data_protection_metrics = try deserializeAdvancedDataProtectionMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AdvancedPerformanceMetrics")) {
                    result.advanced_performance_metrics = try deserializeAdvancedPerformanceMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "BucketLevel")) {
                    result.bucket_level = try deserializeBucketLevel(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DetailedStatusCodesMetrics")) {
                    result.detailed_status_codes_metrics = try deserializeDetailedStatusCodesMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StorageLensGroupLevel")) {
                    result.storage_lens_group_level = try deserializeStorageLensGroupLevel(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeActivityMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ActivityMetrics {
    _ = allocator;
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

pub fn deserializeAdvancedCostOptimizationMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdvancedCostOptimizationMetrics {
    _ = allocator;
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

pub fn deserializeAdvancedDataProtectionMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdvancedDataProtectionMetrics {
    _ = allocator;
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

pub fn deserializeAdvancedPerformanceMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdvancedPerformanceMetrics {
    _ = allocator;
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

pub fn deserializeAsyncErrorDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AsyncErrorDetails {
    var result: AsyncErrorDetails = undefined;
    result.code = null;
    result.message = null;
    result.request_id = null;
    result.resource = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestId")) {
                    result.request_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resource")) {
                    result.resource = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAsyncOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AsyncOperation {
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
                    result.operation = AsyncOperationName.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestParameters")) {
                    result.request_parameters = try deserializeAsyncRequestParameters(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RequestStatus")) {
                    result.request_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestTokenARN")) {
                    result.request_token_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseDetails")) {
                    result.response_details = try deserializeAsyncResponseDetails(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAsyncRequestParameters(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AsyncRequestParameters {
    var result: AsyncRequestParameters = undefined;
    result.create_multi_region_access_point_request = null;
    result.delete_multi_region_access_point_request = null;
    result.put_multi_region_access_point_policy_request = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateMultiRegionAccessPointRequest")) {
                    result.create_multi_region_access_point_request = try deserializeCreateMultiRegionAccessPointInput(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DeleteMultiRegionAccessPointRequest")) {
                    result.delete_multi_region_access_point_request = try deserializeDeleteMultiRegionAccessPointInput(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PutMultiRegionAccessPointPolicyRequest")) {
                    result.put_multi_region_access_point_policy_request = try deserializePutMultiRegionAccessPointPolicyInput(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAsyncResponseDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AsyncResponseDetails {
    var result: AsyncResponseDetails = undefined;
    result.error_details = null;
    result.multi_region_access_point_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorDetails")) {
                    result.error_details = try deserializeAsyncErrorDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MultiRegionAccessPointDetails")) {
                    result.multi_region_access_point_details = try deserializeMultiRegionAccessPointsAsyncResponse(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBucketLevel(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BucketLevel {
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
                    result.activity_metrics = try deserializeActivityMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AdvancedCostOptimizationMetrics")) {
                    result.advanced_cost_optimization_metrics = try deserializeAdvancedCostOptimizationMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AdvancedDataProtectionMetrics")) {
                    result.advanced_data_protection_metrics = try deserializeAdvancedDataProtectionMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AdvancedPerformanceMetrics")) {
                    result.advanced_performance_metrics = try deserializeAdvancedPerformanceMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DetailedStatusCodesMetrics")) {
                    result.detailed_status_codes_metrics = try deserializeDetailedStatusCodesMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PrefixLevel")) {
                    result.prefix_level = try deserializePrefixLevel(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudWatchMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudWatchMetrics {
    _ = allocator;
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

pub fn deserializeCreateMultiRegionAccessPointInput(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CreateMultiRegionAccessPointInput {
    var result: CreateMultiRegionAccessPointInput = undefined;
    result.public_access_block = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicAccessBlock")) {
                    result.public_access_block = try deserializePublicAccessBlockConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionCreationList(allocator, reader, "Region");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCredentials(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Credentials {
    var result: Credentials = undefined;
    result.access_key_id = null;
    result.expiration = null;
    result.secret_access_key = null;
    result.session_token = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeDeleteMarkerReplication(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeleteMarkerReplication {
    _ = allocator;
    var result: DeleteMarkerReplication = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = DeleteMarkerReplicationStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeleteMultiRegionAccessPointInput(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeleteMultiRegionAccessPointInput {
    var result: DeleteMultiRegionAccessPointInput = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
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
                    result.storage_class = ReplicationStorageClass.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDetailedStatusCodesMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DetailedStatusCodesMetrics {
    _ = allocator;
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

pub fn deserializeEstablishedMultiRegionAccessPointPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EstablishedMultiRegionAccessPointPolicy {
    var result: EstablishedMultiRegionAccessPointPolicy = undefined;
    result.policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeExclude(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Exclude {
    var result: Exclude = undefined;
    result.buckets = null;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Buckets")) {
                    result.buckets = try deserializeBuckets(allocator, reader, "Arn");
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegions(allocator, reader, "Region");
                } else {
                    try reader.skipElement();
                }
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

pub fn deserializeGrantee(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Grantee {
    var result: Grantee = undefined;
    result.grantee_identifier = null;
    result.grantee_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GranteeIdentifier")) {
                    result.grantee_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GranteeType")) {
                    result.grantee_type = GranteeType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInclude(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Include {
    var result: Include = undefined;
    result.buckets = null;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Buckets")) {
                    result.buckets = try deserializeBuckets(allocator, reader, "Arn");
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegions(allocator, reader, "Region");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJobDescriptor(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobDescriptor {
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
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureReasons")) {
                    result.failure_reasons = try deserializeJobFailureList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "GeneratedManifestDescriptor")) {
                    result.generated_manifest_descriptor = try deserializeS3GeneratedManifestDescriptor(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "JobArn")) {
                    result.job_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JobId")) {
                    result.job_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Manifest")) {
                    result.manifest = try deserializeJobManifest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ManifestGenerator")) {
                    try reader.skipElement();
                } else if (std.mem.eql(u8, e.local, "Operation")) {
                    result.operation = try deserializeJobOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProgressSummary")) {
                    result.progress_summary = try deserializeJobProgressSummary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Report")) {
                    result.report = try deserializeJobReport(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = JobStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusUpdateReason")) {
                    result.status_update_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuspendedCause")) {
                    result.suspended_cause = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeJobFailure(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobFailure {
    var result: JobFailure = undefined;
    result.failure_code = null;
    result.failure_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailureCode")) {
                    result.failure_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureReason")) {
                    result.failure_reason = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJobListDescriptor(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobListDescriptor {
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
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JobId")) {
                    result.job_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Operation")) {
                    result.operation = OperationName.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProgressSummary")) {
                    result.progress_summary = try deserializeJobProgressSummary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = JobStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeJobManifest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobManifest {
    var result: JobManifest = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Location")) {
                    result.location = try deserializeJobManifestLocation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Spec")) {
                    result.spec = try deserializeJobManifestSpec(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJobManifestLocation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobManifestLocation {
    var result: JobManifestLocation = undefined;
    result.object_version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectArn")) {
                    result.object_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectVersionId")) {
                    result.object_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJobManifestSpec(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobManifestSpec {
    var result: JobManifestSpec = undefined;
    result.fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Fields")) {
                    result.fields = try deserializeJobManifestFieldList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = JobManifestFormat.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJobOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobOperation {
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
                    result.lambda_invoke = try deserializeLambdaInvokeOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3ComputeObjectChecksum")) {
                    result.s3_compute_object_checksum = try deserializeS3ComputeObjectChecksumOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3DeleteObjectTagging")) {
                    result.s3_delete_object_tagging = try deserializeS3DeleteObjectTaggingOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3InitiateRestoreObject")) {
                    result.s3_initiate_restore_object = try deserializeS3InitiateRestoreObjectOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectAcl")) {
                    result.s3_put_object_acl = try deserializeS3SetObjectAclOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectCopy")) {
                    result.s3_put_object_copy = try deserializeS3CopyObjectOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectLegalHold")) {
                    result.s3_put_object_legal_hold = try deserializeS3SetObjectLegalHoldOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectRetention")) {
                    result.s3_put_object_retention = try deserializeS3SetObjectRetentionOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3PutObjectTagging")) {
                    result.s3_put_object_tagging = try deserializeS3SetObjectTaggingOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3ReplicateObject")) {
                    result.s3_replicate_object = try deserializeS3ReplicateObjectOperation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3UpdateObjectEncryption")) {
                    result.s3_update_object_encryption = try deserializeS3UpdateObjectEncryptionOperation(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJobProgressSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobProgressSummary {
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
                    result.timers = try deserializeJobTimers(allocator, reader);
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

pub fn deserializeJobReport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobReport {
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
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ExpectedBucketOwner")) {
                    result.expected_bucket_owner = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = JobReportFormat.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReportScope")) {
                    result.report_scope = JobReportScope.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJobTimers(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JobTimers {
    _ = allocator;
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

pub fn deserializeLambdaInvokeOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LambdaInvokeOperation {
    var result: LambdaInvokeOperation = undefined;
    result.function_arn = null;
    result.invocation_schema_version = null;
    result.user_arguments = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FunctionArn")) {
                    result.function_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationSchemaVersion")) {
                    result.invocation_schema_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserArguments")) {
                    result.user_arguments = try deserializeUserArguments(allocator, reader, "entry");
                } else {
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

pub fn deserializeLifecycleRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LifecycleRule {
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
                    result.abort_incomplete_multipart_upload = try deserializeAbortIncompleteMultipartUpload(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = try deserializeLifecycleExpiration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeLifecycleRuleFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ID")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NoncurrentVersionExpiration")) {
                    result.noncurrent_version_expiration = try deserializeNoncurrentVersionExpiration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NoncurrentVersionTransitions")) {
                    result.noncurrent_version_transitions = try deserializeNoncurrentVersionTransitionList(allocator, reader, "NoncurrentVersionTransition");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ExpirationStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Transitions")) {
                    result.transitions = try deserializeTransitionList(allocator, reader, "Transition");
                } else {
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
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeS3TagSet(allocator, reader, "member");
                } else {
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
                    result.tag = try deserializeS3Tag(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListAccessGrantEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListAccessGrantEntry {
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
                    result.access_grant_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantId")) {
                    result.access_grant_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationConfiguration")) {
                    result.access_grants_location_configuration = try deserializeAccessGrantsLocationConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationId")) {
                    result.access_grants_location_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationArn")) {
                    result.application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeGrantee(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "GrantScope")) {
                    result.grant_scope = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeListAccessGrantsInstanceEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListAccessGrantsInstanceEntry {
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
                    result.access_grants_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsInstanceId")) {
                    result.access_grants_instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IdentityCenterApplicationArn")) {
                    result.identity_center_application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdentityCenterArn")) {
                    result.identity_center_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdentityCenterInstanceArn")) {
                    result.identity_center_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListAccessGrantsLocationsEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListAccessGrantsLocationsEntry {
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
                    result.access_grants_location_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationId")) {
                    result.access_grants_location_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IAMRoleArn")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocationScope")) {
                    result.location_scope = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListCallerAccessGrantsEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListCallerAccessGrantsEntry {
    var result: ListCallerAccessGrantsEntry = undefined;
    result.application_arn = null;
    result.grant_scope = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationArn")) {
                    result.application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GrantScope")) {
                    result.grant_scope = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeListStorageLensConfigurationEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListStorageLensConfigurationEntry {
    var result: ListStorageLensConfigurationEntry = undefined;
    result.is_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HomeRegion")) {
                    result.home_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageLensArn")) {
                    result.storage_lens_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListStorageLensGroupEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListStorageLensGroupEntry {
    var result: ListStorageLensGroupEntry = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HomeRegion")) {
                    result.home_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageLensGroupArn")) {
                    result.storage_lens_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMatchObjectAge(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MatchObjectAge {
    _ = allocator;
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

pub fn deserializeMatchObjectSize(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MatchObjectSize {
    _ = allocator;
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

pub fn deserializeMultiRegionAccessPointPolicyDocument(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MultiRegionAccessPointPolicyDocument {
    var result: MultiRegionAccessPointPolicyDocument = undefined;
    result.established = null;
    result.proposed = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Established")) {
                    result.established = try deserializeEstablishedMultiRegionAccessPointPolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Proposed")) {
                    result.proposed = try deserializeProposedMultiRegionAccessPointPolicy(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMultiRegionAccessPointRegionalResponse(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MultiRegionAccessPointRegionalResponse {
    var result: MultiRegionAccessPointRegionalResponse = undefined;
    result.name = null;
    result.request_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestStatus")) {
                    result.request_status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMultiRegionAccessPointReport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MultiRegionAccessPointReport {
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
                    result.alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicAccessBlock")) {
                    result.public_access_block = try deserializePublicAccessBlockConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionReportList(allocator, reader, "Region");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = MultiRegionAccessPointStatus.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMultiRegionAccessPointRoute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MultiRegionAccessPointRoute {
    var result: MultiRegionAccessPointRoute = undefined;
    result.bucket = null;
    result.region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeMultiRegionAccessPointsAsyncResponse(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MultiRegionAccessPointsAsyncResponse {
    var result: MultiRegionAccessPointsAsyncResponse = undefined;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeMultiRegionAccessPointRegionalResponseList(allocator, reader, "Region");
                } else {
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

pub fn deserializeNoncurrentVersionTransition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NoncurrentVersionTransition {
    _ = allocator;
    var result: NoncurrentVersionTransition = undefined;
    result.noncurrent_days = 0;
    result.storage_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NoncurrentDays")) {
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

pub fn deserializeObjectEncryption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectEncryption {
    var result: ObjectEncryption = undefined;
    result.ssekms = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SSE-KMS")) {
                    result.ssekms = try deserializeS3UpdateObjectEncryptionSSEKMS(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectLambdaAccessPoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLambdaAccessPoint {
    var result: ObjectLambdaAccessPoint = undefined;
    result.alias = null;
    result.object_lambda_access_point_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try deserializeObjectLambdaAccessPointAlias(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectLambdaAccessPointArn")) {
                    result.object_lambda_access_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectLambdaAccessPointAlias(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLambdaAccessPointAlias {
    var result: ObjectLambdaAccessPointAlias = undefined;
    result.status = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ObjectLambdaAccessPointAliasStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeObjectLambdaConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLambdaConfiguration {
    var result: ObjectLambdaConfiguration = undefined;
    result.allowed_features = null;
    result.cloud_watch_metrics_enabled = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedFeatures")) {
                    result.allowed_features = try deserializeObjectLambdaAllowedFeaturesList(allocator, reader, "AllowedFeature");
                } else if (std.mem.eql(u8, e.local, "CloudWatchMetricsEnabled")) {
                    result.cloud_watch_metrics_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportingAccessPoint")) {
                    result.supporting_access_point = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransformationConfigurations")) {
                    result.transformation_configurations = try deserializeObjectLambdaTransformationConfigurationsList(allocator, reader, "TransformationConfiguration");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeObjectLambdaTransformationConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ObjectLambdaTransformationConfiguration {
    var result: ObjectLambdaTransformationConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Actions")) {
                    result.actions = try deserializeObjectLambdaTransformationConfigurationActionsList(allocator, reader, "Action");
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

pub fn deserializePolicyStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyStatus {
    _ = allocator;
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

pub fn deserializePrefixLevel(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PrefixLevel {
    var result: PrefixLevel = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StorageMetrics")) {
                    result.storage_metrics = try deserializePrefixLevelStorageMetrics(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePrefixLevelStorageMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PrefixLevelStorageMetrics {
    var result: PrefixLevelStorageMetrics = undefined;
    result.is_enabled = false;
    result.selection_criteria = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SelectionCriteria")) {
                    result.selection_criteria = try deserializeSelectionCriteria(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeProposedMultiRegionAccessPointPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ProposedMultiRegionAccessPointPolicy {
    var result: ProposedMultiRegionAccessPointPolicy = undefined;
    result.policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try allocator.dupe(u8, try reader.readElementText());
                } else {
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

pub fn deserializePutMultiRegionAccessPointPolicyInput(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PutMultiRegionAccessPointPolicyInput {
    var result: PutMultiRegionAccessPointPolicyInput = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRegion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Region {
    var result: Region = undefined;
    result.bucket_account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRegionReport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RegionReport {
    var result: RegionReport = undefined;
    result.bucket = null;
    result.bucket_account_id = null;
    result.region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketAccountId")) {
                    result.bucket_account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRegionalBucket(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RegionalBucket {
    var result: RegionalBucket = undefined;
    result.bucket_arn = null;
    result.outpost_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BucketArn")) {
                    result.bucket_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutpostId")) {
                    result.outpost_id = try allocator.dupe(u8, try reader.readElementText());
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
                } else if (std.mem.eql(u8, e.local, "Rules")) {
                    result.rules = try deserializeReplicationRules(allocator, reader, "Rule");
                } else {
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
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeleteMarkerReplication")) {
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
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeS3TagSet(allocator, reader, "member");
                } else {
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
                    result.tag = try deserializeS3Tag(allocator, reader);
                } else {
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

pub fn deserializeS3AccessControlList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3AccessControlList {
    var result: S3AccessControlList = undefined;
    result.grants = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grants")) {
                    result.grants = try deserializeS3GrantList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeS3ObjectOwner(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3AccessControlPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3AccessControlPolicy {
    var result: S3AccessControlPolicy = undefined;
    result.access_control_list = null;
    result.canned_access_control_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlList")) {
                    result.access_control_list = try deserializeS3AccessControlList(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CannedAccessControlList")) {
                    result.canned_access_control_list = S3CannedAccessControlList.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3BucketDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3BucketDestination {
    var result: S3BucketDestination = undefined;
    result.encryption = null;
    result.prefix = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Encryption")) {
                    result.encryption = try deserializeStorageLensDataExportEncryption(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = Format.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "OutputSchemaVersion")) {
                    result.output_schema_version = OutputSchemaVersion.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeS3ComputeObjectChecksumOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3ComputeObjectChecksumOperation {
    _ = allocator;
    var result: S3ComputeObjectChecksumOperation = undefined;
    result.checksum_algorithm = null;
    result.checksum_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = ComputeObjectChecksumAlgorithm.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = ComputeObjectChecksumType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3CopyObjectOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3CopyObjectOperation {
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
                    result.access_control_grants = try deserializeS3GrantList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "BucketKeyEnabled")) {
                    result.bucket_key_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CannedAccessControlList")) {
                    result.canned_access_control_list = S3CannedAccessControlList.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = S3ChecksumAlgorithm.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetadataDirective")) {
                    result.metadata_directive = S3MetadataDirective.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModifiedSinceConstraint")) {
                    result.modified_since_constraint = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NewObjectMetadata")) {
                    result.new_object_metadata = try deserializeS3ObjectMetadata(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NewObjectTagging")) {
                    result.new_object_tagging = try deserializeS3TagSet(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ObjectLockLegalHoldStatus")) {
                    result.object_lock_legal_hold_status = S3ObjectLockLegalHoldStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectLockMode")) {
                    result.object_lock_mode = S3ObjectLockMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectLockRetainUntilDate")) {
                    result.object_lock_retain_until_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "RedirectLocation")) {
                    result.redirect_location = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequesterPays")) {
                    result.requester_pays = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SSEAwsKmsKeyId")) {
                    result.sse_aws_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = S3StorageClass.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetKeyPrefix")) {
                    result.target_key_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetResource")) {
                    result.target_resource = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeS3DeleteObjectTaggingOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3DeleteObjectTaggingOperation {
    _ = allocator;
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

pub fn deserializeS3GeneratedManifestDescriptor(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3GeneratedManifestDescriptor {
    var result: S3GeneratedManifestDescriptor = undefined;
    result.format = null;
    result.location = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = GeneratedManifestFormat.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Location")) {
                    result.location = try deserializeJobManifestLocation(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3Grant(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3Grant {
    var result: S3Grant = undefined;
    result.grantee = null;
    result.permission = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try deserializeS3Grantee(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = S3Permission.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3Grantee(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3Grantee {
    var result: S3Grantee = undefined;
    result.display_name = null;
    result.identifier = null;
    result.type_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisplayName")) {
                    result.display_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Identifier")) {
                    result.identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeIdentifier")) {
                    result.type_identifier = S3GranteeTypeIdentifier.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3InitiateRestoreObjectOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3InitiateRestoreObjectOperation {
    _ = allocator;
    var result: S3InitiateRestoreObjectOperation = undefined;
    result.expiration_in_days = null;
    result.glacier_job_tier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExpirationInDays")) {
                    result.expiration_in_days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "GlacierJobTier")) {
                    result.glacier_job_tier = S3GlacierJobTier.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3ObjectLockLegalHold(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3ObjectLockLegalHold {
    _ = allocator;
    var result: S3ObjectLockLegalHold = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = S3ObjectLockLegalHoldStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3ObjectMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3ObjectMetadata {
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
                    result.cache_control = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentDisposition")) {
                    result.content_disposition = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentEncoding")) {
                    result.content_encoding = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentLanguage")) {
                    result.content_language = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentLength")) {
                    result.content_length = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ContentMD5")) {
                    result.content_md5 = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentType")) {
                    result.content_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpExpiresDate")) {
                    result.http_expires_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "RequesterCharged")) {
                    result.requester_charged = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SSEAlgorithm")) {
                    result.sse_algorithm = S3SSEAlgorithm.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserMetadata")) {
                    result.user_metadata = try deserializeS3UserMetadata(allocator, reader, "entry");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3ObjectOwner(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3ObjectOwner {
    var result: S3ObjectOwner = undefined;
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

pub fn deserializeS3ReplicateObjectOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3ReplicateObjectOperation {
    _ = allocator;
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

pub fn deserializeS3Retention(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3Retention {
    _ = allocator;
    var result: S3Retention = undefined;
    result.mode = null;
    result.retain_until_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = S3ObjectLockRetentionMode.fromWireName(try reader.readElementText());
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

pub fn deserializeS3SetObjectAclOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3SetObjectAclOperation {
    var result: S3SetObjectAclOperation = undefined;
    result.access_control_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlPolicy")) {
                    result.access_control_policy = try deserializeS3AccessControlPolicy(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3SetObjectLegalHoldOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3SetObjectLegalHoldOperation {
    var result: S3SetObjectLegalHoldOperation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LegalHold")) {
                    result.legal_hold = try deserializeS3ObjectLockLegalHold(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3SetObjectRetentionOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3SetObjectRetentionOperation {
    var result: S3SetObjectRetentionOperation = undefined;
    result.bypass_governance_retention = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BypassGovernanceRetention")) {
                    result.bypass_governance_retention = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Retention")) {
                    result.retention = try deserializeS3Retention(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3SetObjectTaggingOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3SetObjectTaggingOperation {
    var result: S3SetObjectTaggingOperation = undefined;
    result.tag_set = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TagSet")) {
                    result.tag_set = try deserializeS3TagSet(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3Tag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3Tag {
    var result: S3Tag = undefined;
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

pub fn deserializeS3UpdateObjectEncryptionOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3UpdateObjectEncryptionOperation {
    var result: S3UpdateObjectEncryptionOperation = undefined;
    result.object_encryption = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ObjectEncryption")) {
                    result.object_encryption = try deserializeObjectEncryption(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3UpdateObjectEncryptionSSEKMS(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3UpdateObjectEncryptionSSEKMS {
    var result: S3UpdateObjectEncryptionSSEKMS = undefined;
    result.bucket_key_enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketKeyEnabled")) {
                    result.bucket_key_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KMSKeyArn")) {
                    result.kms_key_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
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

pub fn deserializeScope(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Scope {
    var result: Scope = undefined;
    result.permissions = null;
    result.prefixes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Permissions")) {
                    result.permissions = try deserializeScopePermissionList(allocator, reader, "Permission");
                } else if (std.mem.eql(u8, e.local, "Prefixes")) {
                    result.prefixes = try deserializePrefixesList(allocator, reader, "Prefix");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSelectionCriteria(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SelectionCriteria {
    var result: SelectionCriteria = undefined;
    result.delimiter = null;
    result.max_depth = null;
    result.min_storage_bytes_percentage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Delimiter")) {
                    result.delimiter = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStorageLensAwsOrg(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensAwsOrg {
    var result: StorageLensAwsOrg = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensConfiguration {
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
                    result.account_level = try deserializeAccountLevel(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AwsOrg")) {
                    result.aws_org = try deserializeStorageLensAwsOrg(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DataExport")) {
                    result.data_export = try deserializeStorageLensDataExport(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Exclude")) {
                    result.exclude = try deserializeExclude(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ExpandedPrefixesDataExport")) {
                    result.expanded_prefixes_data_export = try deserializeStorageLensExpandedPrefixesDataExport(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Include")) {
                    result.include = try deserializeInclude(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "IsEnabled")) {
                    result.is_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PrefixDelimiter")) {
                    result.prefix_delimiter = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageLensArn")) {
                    result.storage_lens_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensDataExport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensDataExport {
    var result: StorageLensDataExport = undefined;
    result.cloud_watch_metrics = null;
    result.s3_bucket_destination = null;
    result.storage_lens_table_destination = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchMetrics")) {
                    result.cloud_watch_metrics = try deserializeCloudWatchMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s3_bucket_destination = try deserializeS3BucketDestination(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StorageLensTableDestination")) {
                    result.storage_lens_table_destination = try deserializeStorageLensTableDestination(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensDataExportEncryption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensDataExportEncryption {
    var result: StorageLensDataExportEncryption = undefined;
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

pub fn deserializeStorageLensExpandedPrefixesDataExport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensExpandedPrefixesDataExport {
    var result: StorageLensExpandedPrefixesDataExport = undefined;
    result.s3_bucket_destination = null;
    result.storage_lens_table_destination = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3BucketDestination")) {
                    result.s3_bucket_destination = try deserializeS3BucketDestination(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StorageLensTableDestination")) {
                    result.storage_lens_table_destination = try deserializeStorageLensTableDestination(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensGroup {
    var result: StorageLensGroup = undefined;
    result.storage_lens_group_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Filter")) {
                    result.filter = try deserializeStorageLensGroupFilter(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageLensGroupArn")) {
                    result.storage_lens_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensGroupAndOperator(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensGroupAndOperator {
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
                    result.match_any_prefix = try deserializeMatchAnyPrefix(allocator, reader, "Prefix");
                } else if (std.mem.eql(u8, e.local, "MatchAnySuffix")) {
                    result.match_any_suffix = try deserializeMatchAnySuffix(allocator, reader, "Suffix");
                } else if (std.mem.eql(u8, e.local, "MatchAnyTag")) {
                    result.match_any_tag = try deserializeMatchAnyTag(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "MatchObjectAge")) {
                    result.match_object_age = try deserializeMatchObjectAge(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MatchObjectSize")) {
                    result.match_object_size = try deserializeMatchObjectSize(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensGroupFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensGroupFilter {
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
                    result.@"and" = try deserializeStorageLensGroupAndOperator(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MatchAnyPrefix")) {
                    result.match_any_prefix = try deserializeMatchAnyPrefix(allocator, reader, "Prefix");
                } else if (std.mem.eql(u8, e.local, "MatchAnySuffix")) {
                    result.match_any_suffix = try deserializeMatchAnySuffix(allocator, reader, "Suffix");
                } else if (std.mem.eql(u8, e.local, "MatchAnyTag")) {
                    result.match_any_tag = try deserializeMatchAnyTag(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "MatchObjectAge")) {
                    result.match_object_age = try deserializeMatchObjectAge(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MatchObjectSize")) {
                    result.match_object_size = try deserializeMatchObjectSize(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Or")) {
                    result.@"or" = try deserializeStorageLensGroupOrOperator(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensGroupLevel(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensGroupLevel {
    var result: StorageLensGroupLevel = undefined;
    result.selection_criteria = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SelectionCriteria")) {
                    result.selection_criteria = try deserializeStorageLensGroupLevelSelectionCriteria(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensGroupLevelSelectionCriteria(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensGroupLevelSelectionCriteria {
    var result: StorageLensGroupLevelSelectionCriteria = undefined;
    result.exclude = null;
    result.include = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Exclude")) {
                    result.exclude = try deserializeStorageLensGroupLevelExclude(allocator, reader, "Arn");
                } else if (std.mem.eql(u8, e.local, "Include")) {
                    result.include = try deserializeStorageLensGroupLevelInclude(allocator, reader, "Arn");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensGroupOrOperator(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensGroupOrOperator {
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
                    result.match_any_prefix = try deserializeMatchAnyPrefix(allocator, reader, "Prefix");
                } else if (std.mem.eql(u8, e.local, "MatchAnySuffix")) {
                    result.match_any_suffix = try deserializeMatchAnySuffix(allocator, reader, "Suffix");
                } else if (std.mem.eql(u8, e.local, "MatchAnyTag")) {
                    result.match_any_tag = try deserializeMatchAnyTag(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "MatchObjectAge")) {
                    result.match_object_age = try deserializeMatchObjectAge(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MatchObjectSize")) {
                    result.match_object_size = try deserializeMatchObjectSize(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStorageLensTableDestination(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensTableDestination {
    var result: StorageLensTableDestination = undefined;
    result.encryption = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Encryption")) {
                    result.encryption = try deserializeStorageLensDataExportEncryption(allocator, reader);
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

pub fn deserializeStorageLensTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StorageLensTag {
    var result: StorageLensTag = undefined;
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

pub fn deserializeTransition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Transition {
    _ = allocator;
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

pub fn deserializeVpcConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcConfiguration {
    var result: VpcConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeBuckets(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeJobManifestFieldList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const JobManifestFieldName, comptime item_tag: []const u8) !void {
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

pub fn serializeJobStatusList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const JobStatus, comptime item_tag: []const u8) !void {
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

pub fn serializeMatchAnyPrefix(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeMatchAnySuffix(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeMatchAnyTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const S3Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeS3Tag(allocator, buf, item);
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

pub fn serializeObjectLambdaAllowedFeaturesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectLambdaAllowedFeature, comptime item_tag: []const u8) !void {
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

pub fn serializeObjectLambdaTransformationConfigurationActionsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectLambdaTransformationConfigurationAction, comptime item_tag: []const u8) !void {
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

pub fn serializeObjectLambdaTransformationConfigurationsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ObjectLambdaTransformationConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeObjectLambdaTransformationConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePrefixesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRegionCreationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Region, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRegion(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRegions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRouteList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MultiRegionAccessPointRoute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMultiRegionAccessPointRoute(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeS3GrantList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const S3Grant, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeS3Grant(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeS3TagSet(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const S3Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeS3Tag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeScopePermissionList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScopePermission, comptime item_tag: []const u8) !void {
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

pub fn serializeStorageLensGroupLevelExclude(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeStorageLensGroupLevelInclude(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeStorageLensTags(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StorageLensTag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeStorageLensTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagKeyList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTagList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
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

pub fn serializeS3UserMetadata(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
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

pub fn serializeUserArguments(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
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

pub fn serializeAccessControlTranslation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessControlTranslation) !void {
    try buf.appendSlice(allocator, "<Owner>");
    try buf.appendSlice(allocator, value.owner.wireName());
    try buf.appendSlice(allocator, "</Owner>");
}

pub fn serializeAccessGrantsLocationConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccessGrantsLocationConfiguration) !void {
    if (value.s3_sub_prefix) |v| {
        try buf.appendSlice(allocator, "<S3SubPrefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3SubPrefix>");
    }
}

pub fn serializeAccountLevel(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AccountLevel) !void {
    if (value.activity_metrics) |v| {
        try buf.appendSlice(allocator, "<ActivityMetrics>");
        try serializeActivityMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</ActivityMetrics>");
    }
    if (value.advanced_cost_optimization_metrics) |v| {
        try buf.appendSlice(allocator, "<AdvancedCostOptimizationMetrics>");
        try serializeAdvancedCostOptimizationMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</AdvancedCostOptimizationMetrics>");
    }
    if (value.advanced_data_protection_metrics) |v| {
        try buf.appendSlice(allocator, "<AdvancedDataProtectionMetrics>");
        try serializeAdvancedDataProtectionMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</AdvancedDataProtectionMetrics>");
    }
    if (value.advanced_performance_metrics) |v| {
        try buf.appendSlice(allocator, "<AdvancedPerformanceMetrics>");
        try serializeAdvancedPerformanceMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</AdvancedPerformanceMetrics>");
    }
    try buf.appendSlice(allocator, "<BucketLevel>");
    try serializeBucketLevel(allocator, buf, value.bucket_level);
    try buf.appendSlice(allocator, "</BucketLevel>");
    if (value.detailed_status_codes_metrics) |v| {
        try buf.appendSlice(allocator, "<DetailedStatusCodesMetrics>");
        try serializeDetailedStatusCodesMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</DetailedStatusCodesMetrics>");
    }
    if (value.storage_lens_group_level) |v| {
        try buf.appendSlice(allocator, "<StorageLensGroupLevel>");
        try serializeStorageLensGroupLevel(allocator, buf, v);
        try buf.appendSlice(allocator, "</StorageLensGroupLevel>");
    }
}

pub fn serializeActivityMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ActivityMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(allocator, "<IsEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsEnabled>");
    }
}

pub fn serializeAdvancedCostOptimizationMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdvancedCostOptimizationMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(allocator, "<IsEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsEnabled>");
    }
}

pub fn serializeAdvancedDataProtectionMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdvancedDataProtectionMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(allocator, "<IsEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsEnabled>");
    }
}

pub fn serializeAdvancedPerformanceMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdvancedPerformanceMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(allocator, "<IsEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsEnabled>");
    }
}

pub fn serializeBucketLevel(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BucketLevel) !void {
    if (value.activity_metrics) |v| {
        try buf.appendSlice(allocator, "<ActivityMetrics>");
        try serializeActivityMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</ActivityMetrics>");
    }
    if (value.advanced_cost_optimization_metrics) |v| {
        try buf.appendSlice(allocator, "<AdvancedCostOptimizationMetrics>");
        try serializeAdvancedCostOptimizationMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</AdvancedCostOptimizationMetrics>");
    }
    if (value.advanced_data_protection_metrics) |v| {
        try buf.appendSlice(allocator, "<AdvancedDataProtectionMetrics>");
        try serializeAdvancedDataProtectionMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</AdvancedDataProtectionMetrics>");
    }
    if (value.advanced_performance_metrics) |v| {
        try buf.appendSlice(allocator, "<AdvancedPerformanceMetrics>");
        try serializeAdvancedPerformanceMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</AdvancedPerformanceMetrics>");
    }
    if (value.detailed_status_codes_metrics) |v| {
        try buf.appendSlice(allocator, "<DetailedStatusCodesMetrics>");
        try serializeDetailedStatusCodesMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</DetailedStatusCodesMetrics>");
    }
    if (value.prefix_level) |v| {
        try buf.appendSlice(allocator, "<PrefixLevel>");
        try serializePrefixLevel(allocator, buf, v);
        try buf.appendSlice(allocator, "</PrefixLevel>");
    }
}

pub fn serializeCloudWatchMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchMetrics) !void {
    try buf.appendSlice(allocator, "<IsEnabled>");
    try buf.appendSlice(allocator, if (value.is_enabled) "true" else "false");
    try buf.appendSlice(allocator, "</IsEnabled>");
}

pub fn serializeCreateBucketConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CreateBucketConfiguration) !void {
    if (value.location_constraint) |v| {
        try buf.appendSlice(allocator, "<LocationConstraint>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</LocationConstraint>");
    }
}

pub fn serializeCreateMultiRegionAccessPointInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CreateMultiRegionAccessPointInput) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.public_access_block) |v| {
        try buf.appendSlice(allocator, "<PublicAccessBlock>");
        try serializePublicAccessBlockConfiguration(allocator, buf, v);
        try buf.appendSlice(allocator, "</PublicAccessBlock>");
    }
    try buf.appendSlice(allocator, "<Regions>");
    try serializeRegionCreationList(allocator, buf, value.regions, "Region");
    try buf.appendSlice(allocator, "</Regions>");
}

pub fn serializeDeleteMarkerReplication(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeleteMarkerReplication) !void {
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeDeleteMultiRegionAccessPointInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeleteMultiRegionAccessPointInput) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
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

pub fn serializeDetailedStatusCodesMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DetailedStatusCodesMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(allocator, "<IsEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsEnabled>");
    }
}

pub fn serializeEncryptionConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EncryptionConfiguration) !void {
    if (value.replica_kms_key_id) |v| {
        try buf.appendSlice(allocator, "<ReplicaKmsKeyID>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReplicaKmsKeyID>");
    }
}

pub fn serializeExclude(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Exclude) !void {
    if (value.buckets) |v| {
        try buf.appendSlice(allocator, "<Buckets>");
        try serializeBuckets(allocator, buf, v, "Arn");
        try buf.appendSlice(allocator, "</Buckets>");
    }
    if (value.regions) |v| {
        try buf.appendSlice(allocator, "<Regions>");
        try serializeRegions(allocator, buf, v, "Region");
        try buf.appendSlice(allocator, "</Regions>");
    }
}

pub fn serializeExistingObjectReplication(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ExistingObjectReplication) !void {
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeGrantee(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Grantee) !void {
    if (value.grantee_identifier) |v| {
        try buf.appendSlice(allocator, "<GranteeIdentifier>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</GranteeIdentifier>");
    }
    if (value.grantee_type) |v| {
        try buf.appendSlice(allocator, "<GranteeType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</GranteeType>");
    }
}

pub fn serializeInclude(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Include) !void {
    if (value.buckets) |v| {
        try buf.appendSlice(allocator, "<Buckets>");
        try serializeBuckets(allocator, buf, v, "Arn");
        try buf.appendSlice(allocator, "</Buckets>");
    }
    if (value.regions) |v| {
        try buf.appendSlice(allocator, "<Regions>");
        try serializeRegions(allocator, buf, v, "Region");
        try buf.appendSlice(allocator, "</Regions>");
    }
}

pub fn serializeJobManifest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobManifest) !void {
    try buf.appendSlice(allocator, "<Location>");
    try serializeJobManifestLocation(allocator, buf, value.location);
    try buf.appendSlice(allocator, "</Location>");
    try buf.appendSlice(allocator, "<Spec>");
    try serializeJobManifestSpec(allocator, buf, value.spec);
    try buf.appendSlice(allocator, "</Spec>");
}

pub fn serializeJobManifestLocation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobManifestLocation) !void {
    try buf.appendSlice(allocator, "<ETag>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.e_tag);
    try buf.appendSlice(allocator, "</ETag>");
    try buf.appendSlice(allocator, "<ObjectArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.object_arn);
    try buf.appendSlice(allocator, "</ObjectArn>");
    if (value.object_version_id) |v| {
        try buf.appendSlice(allocator, "<ObjectVersionId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ObjectVersionId>");
    }
}

pub fn serializeJobManifestSpec(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobManifestSpec) !void {
    if (value.fields) |v| {
        try buf.appendSlice(allocator, "<Fields>");
        try serializeJobManifestFieldList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Fields>");
    }
    try buf.appendSlice(allocator, "<Format>");
    try buf.appendSlice(allocator, value.format.wireName());
    try buf.appendSlice(allocator, "</Format>");
}

pub fn serializeJobOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobOperation) !void {
    if (value.lambda_invoke) |v| {
        try buf.appendSlice(allocator, "<LambdaInvoke>");
        try serializeLambdaInvokeOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</LambdaInvoke>");
    }
    if (value.s3_compute_object_checksum) |v| {
        try buf.appendSlice(allocator, "<S3ComputeObjectChecksum>");
        try serializeS3ComputeObjectChecksumOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3ComputeObjectChecksum>");
    }
    if (value.s3_delete_object_tagging) |v| {
        try buf.appendSlice(allocator, "<S3DeleteObjectTagging>");
        try serializeS3DeleteObjectTaggingOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3DeleteObjectTagging>");
    }
    if (value.s3_initiate_restore_object) |v| {
        try buf.appendSlice(allocator, "<S3InitiateRestoreObject>");
        try serializeS3InitiateRestoreObjectOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3InitiateRestoreObject>");
    }
    if (value.s3_put_object_acl) |v| {
        try buf.appendSlice(allocator, "<S3PutObjectAcl>");
        try serializeS3SetObjectAclOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3PutObjectAcl>");
    }
    if (value.s3_put_object_copy) |v| {
        try buf.appendSlice(allocator, "<S3PutObjectCopy>");
        try serializeS3CopyObjectOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3PutObjectCopy>");
    }
    if (value.s3_put_object_legal_hold) |v| {
        try buf.appendSlice(allocator, "<S3PutObjectLegalHold>");
        try serializeS3SetObjectLegalHoldOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3PutObjectLegalHold>");
    }
    if (value.s3_put_object_retention) |v| {
        try buf.appendSlice(allocator, "<S3PutObjectRetention>");
        try serializeS3SetObjectRetentionOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3PutObjectRetention>");
    }
    if (value.s3_put_object_tagging) |v| {
        try buf.appendSlice(allocator, "<S3PutObjectTagging>");
        try serializeS3SetObjectTaggingOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3PutObjectTagging>");
    }
    if (value.s3_replicate_object) |v| {
        try buf.appendSlice(allocator, "<S3ReplicateObject>");
        try serializeS3ReplicateObjectOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3ReplicateObject>");
    }
    if (value.s3_update_object_encryption) |v| {
        try buf.appendSlice(allocator, "<S3UpdateObjectEncryption>");
        try serializeS3UpdateObjectEncryptionOperation(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3UpdateObjectEncryption>");
    }
}

pub fn serializeJobReport(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JobReport) !void {
    if (value.bucket) |v| {
        try buf.appendSlice(allocator, "<Bucket>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Bucket>");
    }
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.expected_bucket_owner) |v| {
        try buf.appendSlice(allocator, "<ExpectedBucketOwner>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ExpectedBucketOwner>");
    }
    if (value.format) |v| {
        try buf.appendSlice(allocator, "<Format>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Format>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
    if (value.report_scope) |v| {
        try buf.appendSlice(allocator, "<ReportScope>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ReportScope>");
    }
}

pub fn serializeLambdaInvokeOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaInvokeOperation) !void {
    if (value.function_arn) |v| {
        try buf.appendSlice(allocator, "<FunctionArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</FunctionArn>");
    }
    if (value.invocation_schema_version) |v| {
        try buf.appendSlice(allocator, "<InvocationSchemaVersion>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</InvocationSchemaVersion>");
    }
    if (value.user_arguments) |v| {
        try buf.appendSlice(allocator, "<UserArguments>");
        try serializeUserArguments(allocator, buf, v, "entry");
        try buf.appendSlice(allocator, "</UserArguments>");
    }
}

pub fn serializeLifecycleConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleConfiguration) !void {
    if (value.rules) |v| {
        try buf.appendSlice(allocator, "<Rules>");
        try serializeLifecycleRules(allocator, buf, v, "Rule");
        try buf.appendSlice(allocator, "</Rules>");
    }
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
        try buf.appendSlice(allocator, "<NoncurrentVersionTransitions>");
        try serializeNoncurrentVersionTransitionList(allocator, buf, v, "NoncurrentVersionTransition");
        try buf.appendSlice(allocator, "</NoncurrentVersionTransitions>");
    }
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
    if (value.transitions) |v| {
        try buf.appendSlice(allocator, "<Transitions>");
        try serializeTransitionList(allocator, buf, v, "Transition");
        try buf.appendSlice(allocator, "</Transitions>");
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
        try buf.appendSlice(allocator, "<Tags>");
        try serializeS3TagSet(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Tags>");
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
        try serializeS3Tag(allocator, buf, v);
        try buf.appendSlice(allocator, "</Tag>");
    }
}

pub fn serializeMatchObjectAge(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MatchObjectAge) !void {
    if (value.days_greater_than) |v| {
        try buf.appendSlice(allocator, "<DaysGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DaysGreaterThan>");
    }
    if (value.days_less_than) |v| {
        try buf.appendSlice(allocator, "<DaysLessThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DaysLessThan>");
    }
}

pub fn serializeMatchObjectSize(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MatchObjectSize) !void {
    if (value.bytes_greater_than) |v| {
        try buf.appendSlice(allocator, "<BytesGreaterThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</BytesGreaterThan>");
    }
    if (value.bytes_less_than) |v| {
        try buf.appendSlice(allocator, "<BytesLessThan>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</BytesLessThan>");
    }
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

pub fn serializeMultiRegionAccessPointRoute(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MultiRegionAccessPointRoute) !void {
    if (value.bucket) |v| {
        try buf.appendSlice(allocator, "<Bucket>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Bucket>");
    }
    if (value.region) |v| {
        try buf.appendSlice(allocator, "<Region>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Region>");
    }
    try buf.appendSlice(allocator, "<TrafficDialPercentage>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.traffic_dial_percentage}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</TrafficDialPercentage>");
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

pub fn serializeObjectEncryption(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectEncryption) !void {
    if (value.ssekms) |v| {
        try buf.appendSlice(allocator, "<SSE-KMS>");
        try serializeS3UpdateObjectEncryptionSSEKMS(allocator, buf, v);
        try buf.appendSlice(allocator, "</SSE-KMS>");
    }
}

pub fn serializeObjectLambdaConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLambdaConfiguration) !void {
    if (value.allowed_features) |v| {
        try buf.appendSlice(allocator, "<AllowedFeatures>");
        try serializeObjectLambdaAllowedFeaturesList(allocator, buf, v, "AllowedFeature");
        try buf.appendSlice(allocator, "</AllowedFeatures>");
    }
    if (value.cloud_watch_metrics_enabled) |v| {
        try buf.appendSlice(allocator, "<CloudWatchMetricsEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</CloudWatchMetricsEnabled>");
    }
    try buf.appendSlice(allocator, "<SupportingAccessPoint>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.supporting_access_point);
    try buf.appendSlice(allocator, "</SupportingAccessPoint>");
    try buf.appendSlice(allocator, "<TransformationConfigurations>");
    try serializeObjectLambdaTransformationConfigurationsList(allocator, buf, value.transformation_configurations, "TransformationConfiguration");
    try buf.appendSlice(allocator, "</TransformationConfigurations>");
}

pub fn serializeObjectLambdaTransformationConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ObjectLambdaTransformationConfiguration) !void {
    try buf.appendSlice(allocator, "<Actions>");
    try serializeObjectLambdaTransformationConfigurationActionsList(allocator, buf, value.actions, "Action");
    try buf.appendSlice(allocator, "</Actions>");
}

pub fn serializePrefixLevel(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PrefixLevel) !void {
    try buf.appendSlice(allocator, "<StorageMetrics>");
    try serializePrefixLevelStorageMetrics(allocator, buf, value.storage_metrics);
    try buf.appendSlice(allocator, "</StorageMetrics>");
}

pub fn serializePrefixLevelStorageMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PrefixLevelStorageMetrics) !void {
    if (value.is_enabled) |v| {
        try buf.appendSlice(allocator, "<IsEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsEnabled>");
    }
    if (value.selection_criteria) |v| {
        try buf.appendSlice(allocator, "<SelectionCriteria>");
        try serializeSelectionCriteria(allocator, buf, v);
        try buf.appendSlice(allocator, "</SelectionCriteria>");
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

pub fn serializePutMultiRegionAccessPointPolicyInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PutMultiRegionAccessPointPolicyInput) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Policy>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.policy);
    try buf.appendSlice(allocator, "</Policy>");
}

pub fn serializeRegion(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Region) !void {
    try buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket);
    try buf.appendSlice(allocator, "</Bucket>");
    if (value.bucket_account_id) |v| {
        try buf.appendSlice(allocator, "<BucketAccountId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</BucketAccountId>");
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
    try buf.appendSlice(allocator, "<Rules>");
    try serializeReplicationRules(allocator, buf, value.rules, "Rule");
    try buf.appendSlice(allocator, "</Rules>");
}

pub fn serializeReplicationRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReplicationRule) !void {
    try buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket);
    try buf.appendSlice(allocator, "</Bucket>");
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
        try buf.appendSlice(allocator, "<Tags>");
        try serializeS3TagSet(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Tags>");
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
        try serializeS3Tag(allocator, buf, v);
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

pub fn serializeS3AccessControlList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3AccessControlList) !void {
    if (value.grants) |v| {
        try buf.appendSlice(allocator, "<Grants>");
        try serializeS3GrantList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Grants>");
    }
    try buf.appendSlice(allocator, "<Owner>");
    try serializeS3ObjectOwner(allocator, buf, value.owner);
    try buf.appendSlice(allocator, "</Owner>");
}

pub fn serializeS3AccessControlPolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3AccessControlPolicy) !void {
    if (value.access_control_list) |v| {
        try buf.appendSlice(allocator, "<AccessControlList>");
        try serializeS3AccessControlList(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccessControlList>");
    }
    if (value.canned_access_control_list) |v| {
        try buf.appendSlice(allocator, "<CannedAccessControlList>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</CannedAccessControlList>");
    }
}

pub fn serializeS3BucketDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3BucketDestination) !void {
    try buf.appendSlice(allocator, "<AccountId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.account_id);
    try buf.appendSlice(allocator, "</AccountId>");
    try buf.appendSlice(allocator, "<Arn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.arn);
    try buf.appendSlice(allocator, "</Arn>");
    if (value.encryption) |v| {
        try buf.appendSlice(allocator, "<Encryption>");
        try serializeStorageLensDataExportEncryption(allocator, buf, v);
        try buf.appendSlice(allocator, "</Encryption>");
    }
    try buf.appendSlice(allocator, "<Format>");
    try buf.appendSlice(allocator, value.format.wireName());
    try buf.appendSlice(allocator, "</Format>");
    try buf.appendSlice(allocator, "<OutputSchemaVersion>");
    try buf.appendSlice(allocator, value.output_schema_version.wireName());
    try buf.appendSlice(allocator, "</OutputSchemaVersion>");
    if (value.prefix) |v| {
        try buf.appendSlice(allocator, "<Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Prefix>");
    }
}

pub fn serializeS3ComputeObjectChecksumOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ComputeObjectChecksumOperation) !void {
    if (value.checksum_algorithm) |v| {
        try buf.appendSlice(allocator, "<ChecksumAlgorithm>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ChecksumAlgorithm>");
    }
    if (value.checksum_type) |v| {
        try buf.appendSlice(allocator, "<ChecksumType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ChecksumType>");
    }
}

pub fn serializeS3CopyObjectOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3CopyObjectOperation) !void {
    if (value.access_control_grants) |v| {
        try buf.appendSlice(allocator, "<AccessControlGrants>");
        try serializeS3GrantList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AccessControlGrants>");
    }
    if (value.bucket_key_enabled) |v| {
        try buf.appendSlice(allocator, "<BucketKeyEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</BucketKeyEnabled>");
    }
    if (value.canned_access_control_list) |v| {
        try buf.appendSlice(allocator, "<CannedAccessControlList>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</CannedAccessControlList>");
    }
    if (value.checksum_algorithm) |v| {
        try buf.appendSlice(allocator, "<ChecksumAlgorithm>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ChecksumAlgorithm>");
    }
    if (value.metadata_directive) |v| {
        try buf.appendSlice(allocator, "<MetadataDirective>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</MetadataDirective>");
    }
    if (value.modified_since_constraint) |v| {
        try buf.appendSlice(allocator, "<ModifiedSinceConstraint>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</ModifiedSinceConstraint>");
    }
    if (value.new_object_metadata) |v| {
        try buf.appendSlice(allocator, "<NewObjectMetadata>");
        try serializeS3ObjectMetadata(allocator, buf, v);
        try buf.appendSlice(allocator, "</NewObjectMetadata>");
    }
    if (value.new_object_tagging) |v| {
        try buf.appendSlice(allocator, "<NewObjectTagging>");
        try serializeS3TagSet(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</NewObjectTagging>");
    }
    if (value.object_lock_legal_hold_status) |v| {
        try buf.appendSlice(allocator, "<ObjectLockLegalHoldStatus>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ObjectLockLegalHoldStatus>");
    }
    if (value.object_lock_mode) |v| {
        try buf.appendSlice(allocator, "<ObjectLockMode>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ObjectLockMode>");
    }
    if (value.object_lock_retain_until_date) |v| {
        try buf.appendSlice(allocator, "<ObjectLockRetainUntilDate>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</ObjectLockRetainUntilDate>");
    }
    if (value.redirect_location) |v| {
        try buf.appendSlice(allocator, "<RedirectLocation>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RedirectLocation>");
    }
    if (value.requester_pays) |v| {
        try buf.appendSlice(allocator, "<RequesterPays>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</RequesterPays>");
    }
    if (value.sse_aws_kms_key_id) |v| {
        try buf.appendSlice(allocator, "<SSEAwsKmsKeyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SSEAwsKmsKeyId>");
    }
    if (value.storage_class) |v| {
        try buf.appendSlice(allocator, "<StorageClass>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</StorageClass>");
    }
    if (value.target_key_prefix) |v| {
        try buf.appendSlice(allocator, "<TargetKeyPrefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TargetKeyPrefix>");
    }
    if (value.target_resource) |v| {
        try buf.appendSlice(allocator, "<TargetResource>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TargetResource>");
    }
    if (value.un_modified_since_constraint) |v| {
        try buf.appendSlice(allocator, "<UnModifiedSinceConstraint>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</UnModifiedSinceConstraint>");
    }
}

pub fn serializeS3DeleteObjectTaggingOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3DeleteObjectTaggingOperation) !void {
    _ = allocator;
    _ = buf;
    _ = value;
}

pub fn serializeS3Grant(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Grant) !void {
    if (value.grantee) |v| {
        try buf.appendSlice(allocator, "<Grantee>");
        try serializeS3Grantee(allocator, buf, v);
        try buf.appendSlice(allocator, "</Grantee>");
    }
    if (value.permission) |v| {
        try buf.appendSlice(allocator, "<Permission>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Permission>");
    }
}

pub fn serializeS3Grantee(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Grantee) !void {
    if (value.display_name) |v| {
        try buf.appendSlice(allocator, "<DisplayName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DisplayName>");
    }
    if (value.identifier) |v| {
        try buf.appendSlice(allocator, "<Identifier>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Identifier>");
    }
    if (value.type_identifier) |v| {
        try buf.appendSlice(allocator, "<TypeIdentifier>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</TypeIdentifier>");
    }
}

pub fn serializeS3InitiateRestoreObjectOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3InitiateRestoreObjectOperation) !void {
    if (value.expiration_in_days) |v| {
        try buf.appendSlice(allocator, "<ExpirationInDays>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ExpirationInDays>");
    }
    if (value.glacier_job_tier) |v| {
        try buf.appendSlice(allocator, "<GlacierJobTier>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</GlacierJobTier>");
    }
}

pub fn serializeS3ObjectLockLegalHold(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ObjectLockLegalHold) !void {
    try buf.appendSlice(allocator, "<Status>");
    try buf.appendSlice(allocator, value.status.wireName());
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeS3ObjectMetadata(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ObjectMetadata) !void {
    if (value.cache_control) |v| {
        try buf.appendSlice(allocator, "<CacheControl>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</CacheControl>");
    }
    if (value.content_disposition) |v| {
        try buf.appendSlice(allocator, "<ContentDisposition>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentDisposition>");
    }
    if (value.content_encoding) |v| {
        try buf.appendSlice(allocator, "<ContentEncoding>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentEncoding>");
    }
    if (value.content_language) |v| {
        try buf.appendSlice(allocator, "<ContentLanguage>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentLanguage>");
    }
    if (value.content_length) |v| {
        try buf.appendSlice(allocator, "<ContentLength>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ContentLength>");
    }
    if (value.content_md5) |v| {
        try buf.appendSlice(allocator, "<ContentMD5>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentMD5>");
    }
    if (value.content_type) |v| {
        try buf.appendSlice(allocator, "<ContentType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentType>");
    }
    if (value.http_expires_date) |v| {
        try buf.appendSlice(allocator, "<HttpExpiresDate>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</HttpExpiresDate>");
    }
    if (value.requester_charged) |v| {
        try buf.appendSlice(allocator, "<RequesterCharged>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</RequesterCharged>");
    }
    if (value.sse_algorithm) |v| {
        try buf.appendSlice(allocator, "<SSEAlgorithm>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</SSEAlgorithm>");
    }
    if (value.user_metadata) |v| {
        try buf.appendSlice(allocator, "<UserMetadata>");
        try serializeS3UserMetadata(allocator, buf, v, "entry");
        try buf.appendSlice(allocator, "</UserMetadata>");
    }
}

pub fn serializeS3ObjectOwner(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ObjectOwner) !void {
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

pub fn serializeS3ReplicateObjectOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3ReplicateObjectOperation) !void {
    _ = allocator;
    _ = buf;
    _ = value;
}

pub fn serializeS3Retention(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Retention) !void {
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

pub fn serializeS3SetObjectAclOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectAclOperation) !void {
    if (value.access_control_policy) |v| {
        try buf.appendSlice(allocator, "<AccessControlPolicy>");
        try serializeS3AccessControlPolicy(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccessControlPolicy>");
    }
}

pub fn serializeS3SetObjectLegalHoldOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectLegalHoldOperation) !void {
    try buf.appendSlice(allocator, "<LegalHold>");
    try serializeS3ObjectLockLegalHold(allocator, buf, value.legal_hold);
    try buf.appendSlice(allocator, "</LegalHold>");
}

pub fn serializeS3SetObjectRetentionOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectRetentionOperation) !void {
    if (value.bypass_governance_retention) |v| {
        try buf.appendSlice(allocator, "<BypassGovernanceRetention>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</BypassGovernanceRetention>");
    }
    try buf.appendSlice(allocator, "<Retention>");
    try serializeS3Retention(allocator, buf, value.retention);
    try buf.appendSlice(allocator, "</Retention>");
}

pub fn serializeS3SetObjectTaggingOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3SetObjectTaggingOperation) !void {
    if (value.tag_set) |v| {
        try buf.appendSlice(allocator, "<TagSet>");
        try serializeS3TagSet(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</TagSet>");
    }
}

pub fn serializeS3Tag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeS3UpdateObjectEncryptionOperation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3UpdateObjectEncryptionOperation) !void {
    if (value.object_encryption) |v| {
        try buf.appendSlice(allocator, "<ObjectEncryption>");
        try serializeObjectEncryption(allocator, buf, v);
        try buf.appendSlice(allocator, "</ObjectEncryption>");
    }
}

pub fn serializeS3UpdateObjectEncryptionSSEKMS(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3UpdateObjectEncryptionSSEKMS) !void {
    if (value.bucket_key_enabled) |v| {
        try buf.appendSlice(allocator, "<BucketKeyEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</BucketKeyEnabled>");
    }
    try buf.appendSlice(allocator, "<KMSKeyArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.kms_key_arn);
    try buf.appendSlice(allocator, "</KMSKeyArn>");
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

pub fn serializeScope(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Scope) !void {
    if (value.permissions) |v| {
        try buf.appendSlice(allocator, "<Permissions>");
        try serializeScopePermissionList(allocator, buf, v, "Permission");
        try buf.appendSlice(allocator, "</Permissions>");
    }
    if (value.prefixes) |v| {
        try buf.appendSlice(allocator, "<Prefixes>");
        try serializePrefixesList(allocator, buf, v, "Prefix");
        try buf.appendSlice(allocator, "</Prefixes>");
    }
}

pub fn serializeSelectionCriteria(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SelectionCriteria) !void {
    if (value.delimiter) |v| {
        try buf.appendSlice(allocator, "<Delimiter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Delimiter>");
    }
    if (value.max_depth) |v| {
        try buf.appendSlice(allocator, "<MaxDepth>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxDepth>");
    }
    if (value.min_storage_bytes_percentage) |v| {
        try buf.appendSlice(allocator, "<MinStorageBytesPercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinStorageBytesPercentage>");
    }
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

pub fn serializeStorageLensAwsOrg(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensAwsOrg) !void {
    try buf.appendSlice(allocator, "<Arn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.arn);
    try buf.appendSlice(allocator, "</Arn>");
}

pub fn serializeStorageLensConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensConfiguration) !void {
    try buf.appendSlice(allocator, "<AccountLevel>");
    try serializeAccountLevel(allocator, buf, value.account_level);
    try buf.appendSlice(allocator, "</AccountLevel>");
    if (value.aws_org) |v| {
        try buf.appendSlice(allocator, "<AwsOrg>");
        try serializeStorageLensAwsOrg(allocator, buf, v);
        try buf.appendSlice(allocator, "</AwsOrg>");
    }
    if (value.data_export) |v| {
        try buf.appendSlice(allocator, "<DataExport>");
        try serializeStorageLensDataExport(allocator, buf, v);
        try buf.appendSlice(allocator, "</DataExport>");
    }
    if (value.exclude) |v| {
        try buf.appendSlice(allocator, "<Exclude>");
        try serializeExclude(allocator, buf, v);
        try buf.appendSlice(allocator, "</Exclude>");
    }
    if (value.expanded_prefixes_data_export) |v| {
        try buf.appendSlice(allocator, "<ExpandedPrefixesDataExport>");
        try serializeStorageLensExpandedPrefixesDataExport(allocator, buf, v);
        try buf.appendSlice(allocator, "</ExpandedPrefixesDataExport>");
    }
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    if (value.include) |v| {
        try buf.appendSlice(allocator, "<Include>");
        try serializeInclude(allocator, buf, v);
        try buf.appendSlice(allocator, "</Include>");
    }
    try buf.appendSlice(allocator, "<IsEnabled>");
    try buf.appendSlice(allocator, if (value.is_enabled) "true" else "false");
    try buf.appendSlice(allocator, "</IsEnabled>");
    if (value.prefix_delimiter) |v| {
        try buf.appendSlice(allocator, "<PrefixDelimiter>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</PrefixDelimiter>");
    }
    if (value.storage_lens_arn) |v| {
        try buf.appendSlice(allocator, "<StorageLensArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StorageLensArn>");
    }
}

pub fn serializeStorageLensDataExport(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensDataExport) !void {
    if (value.cloud_watch_metrics) |v| {
        try buf.appendSlice(allocator, "<CloudWatchMetrics>");
        try serializeCloudWatchMetrics(allocator, buf, v);
        try buf.appendSlice(allocator, "</CloudWatchMetrics>");
    }
    if (value.s3_bucket_destination) |v| {
        try buf.appendSlice(allocator, "<S3BucketDestination>");
        try serializeS3BucketDestination(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3BucketDestination>");
    }
    if (value.storage_lens_table_destination) |v| {
        try buf.appendSlice(allocator, "<StorageLensTableDestination>");
        try serializeStorageLensTableDestination(allocator, buf, v);
        try buf.appendSlice(allocator, "</StorageLensTableDestination>");
    }
}

pub fn serializeStorageLensDataExportEncryption(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensDataExportEncryption) !void {
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

pub fn serializeStorageLensExpandedPrefixesDataExport(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensExpandedPrefixesDataExport) !void {
    if (value.s3_bucket_destination) |v| {
        try buf.appendSlice(allocator, "<S3BucketDestination>");
        try serializeS3BucketDestination(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3BucketDestination>");
    }
    if (value.storage_lens_table_destination) |v| {
        try buf.appendSlice(allocator, "<StorageLensTableDestination>");
        try serializeStorageLensTableDestination(allocator, buf, v);
        try buf.appendSlice(allocator, "</StorageLensTableDestination>");
    }
}

pub fn serializeStorageLensGroup(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroup) !void {
    try buf.appendSlice(allocator, "<Filter>");
    try serializeStorageLensGroupFilter(allocator, buf, value.filter);
    try buf.appendSlice(allocator, "</Filter>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.storage_lens_group_arn) |v| {
        try buf.appendSlice(allocator, "<StorageLensGroupArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StorageLensGroupArn>");
    }
}

pub fn serializeStorageLensGroupAndOperator(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupAndOperator) !void {
    if (value.match_any_prefix) |v| {
        try buf.appendSlice(allocator, "<MatchAnyPrefix>");
        try serializeMatchAnyPrefix(allocator, buf, v, "Prefix");
        try buf.appendSlice(allocator, "</MatchAnyPrefix>");
    }
    if (value.match_any_suffix) |v| {
        try buf.appendSlice(allocator, "<MatchAnySuffix>");
        try serializeMatchAnySuffix(allocator, buf, v, "Suffix");
        try buf.appendSlice(allocator, "</MatchAnySuffix>");
    }
    if (value.match_any_tag) |v| {
        try buf.appendSlice(allocator, "<MatchAnyTag>");
        try serializeMatchAnyTag(allocator, buf, v, "Tag");
        try buf.appendSlice(allocator, "</MatchAnyTag>");
    }
    if (value.match_object_age) |v| {
        try buf.appendSlice(allocator, "<MatchObjectAge>");
        try serializeMatchObjectAge(allocator, buf, v);
        try buf.appendSlice(allocator, "</MatchObjectAge>");
    }
    if (value.match_object_size) |v| {
        try buf.appendSlice(allocator, "<MatchObjectSize>");
        try serializeMatchObjectSize(allocator, buf, v);
        try buf.appendSlice(allocator, "</MatchObjectSize>");
    }
}

pub fn serializeStorageLensGroupFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupFilter) !void {
    if (value.@"and") |v| {
        try buf.appendSlice(allocator, "<And>");
        try serializeStorageLensGroupAndOperator(allocator, buf, v);
        try buf.appendSlice(allocator, "</And>");
    }
    if (value.match_any_prefix) |v| {
        try buf.appendSlice(allocator, "<MatchAnyPrefix>");
        try serializeMatchAnyPrefix(allocator, buf, v, "Prefix");
        try buf.appendSlice(allocator, "</MatchAnyPrefix>");
    }
    if (value.match_any_suffix) |v| {
        try buf.appendSlice(allocator, "<MatchAnySuffix>");
        try serializeMatchAnySuffix(allocator, buf, v, "Suffix");
        try buf.appendSlice(allocator, "</MatchAnySuffix>");
    }
    if (value.match_any_tag) |v| {
        try buf.appendSlice(allocator, "<MatchAnyTag>");
        try serializeMatchAnyTag(allocator, buf, v, "Tag");
        try buf.appendSlice(allocator, "</MatchAnyTag>");
    }
    if (value.match_object_age) |v| {
        try buf.appendSlice(allocator, "<MatchObjectAge>");
        try serializeMatchObjectAge(allocator, buf, v);
        try buf.appendSlice(allocator, "</MatchObjectAge>");
    }
    if (value.match_object_size) |v| {
        try buf.appendSlice(allocator, "<MatchObjectSize>");
        try serializeMatchObjectSize(allocator, buf, v);
        try buf.appendSlice(allocator, "</MatchObjectSize>");
    }
    if (value.@"or") |v| {
        try buf.appendSlice(allocator, "<Or>");
        try serializeStorageLensGroupOrOperator(allocator, buf, v);
        try buf.appendSlice(allocator, "</Or>");
    }
}

pub fn serializeStorageLensGroupLevel(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupLevel) !void {
    if (value.selection_criteria) |v| {
        try buf.appendSlice(allocator, "<SelectionCriteria>");
        try serializeStorageLensGroupLevelSelectionCriteria(allocator, buf, v);
        try buf.appendSlice(allocator, "</SelectionCriteria>");
    }
}

pub fn serializeStorageLensGroupLevelSelectionCriteria(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupLevelSelectionCriteria) !void {
    if (value.exclude) |v| {
        try buf.appendSlice(allocator, "<Exclude>");
        try serializeStorageLensGroupLevelExclude(allocator, buf, v, "Arn");
        try buf.appendSlice(allocator, "</Exclude>");
    }
    if (value.include) |v| {
        try buf.appendSlice(allocator, "<Include>");
        try serializeStorageLensGroupLevelInclude(allocator, buf, v, "Arn");
        try buf.appendSlice(allocator, "</Include>");
    }
}

pub fn serializeStorageLensGroupOrOperator(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensGroupOrOperator) !void {
    if (value.match_any_prefix) |v| {
        try buf.appendSlice(allocator, "<MatchAnyPrefix>");
        try serializeMatchAnyPrefix(allocator, buf, v, "Prefix");
        try buf.appendSlice(allocator, "</MatchAnyPrefix>");
    }
    if (value.match_any_suffix) |v| {
        try buf.appendSlice(allocator, "<MatchAnySuffix>");
        try serializeMatchAnySuffix(allocator, buf, v, "Suffix");
        try buf.appendSlice(allocator, "</MatchAnySuffix>");
    }
    if (value.match_any_tag) |v| {
        try buf.appendSlice(allocator, "<MatchAnyTag>");
        try serializeMatchAnyTag(allocator, buf, v, "Tag");
        try buf.appendSlice(allocator, "</MatchAnyTag>");
    }
    if (value.match_object_age) |v| {
        try buf.appendSlice(allocator, "<MatchObjectAge>");
        try serializeMatchObjectAge(allocator, buf, v);
        try buf.appendSlice(allocator, "</MatchObjectAge>");
    }
    if (value.match_object_size) |v| {
        try buf.appendSlice(allocator, "<MatchObjectSize>");
        try serializeMatchObjectSize(allocator, buf, v);
        try buf.appendSlice(allocator, "</MatchObjectSize>");
    }
}

pub fn serializeStorageLensTableDestination(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensTableDestination) !void {
    if (value.encryption) |v| {
        try buf.appendSlice(allocator, "<Encryption>");
        try serializeStorageLensDataExportEncryption(allocator, buf, v);
        try buf.appendSlice(allocator, "</Encryption>");
    }
    try buf.appendSlice(allocator, "<IsEnabled>");
    try buf.appendSlice(allocator, if (value.is_enabled) "true" else "false");
    try buf.appendSlice(allocator, "</IsEnabled>");
}

pub fn serializeStorageLensTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StorageLensTag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
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
    try serializeS3TagSet(allocator, buf, value.tag_set, "member");
    try buf.appendSlice(allocator, "</TagSet>");
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

pub fn serializeVpcConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: VpcConfiguration) !void {
    try buf.appendSlice(allocator, "<VpcId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.vpc_id);
    try buf.appendSlice(allocator, "</VpcId>");
}

