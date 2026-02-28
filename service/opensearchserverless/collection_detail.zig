const FipsEndpoints = @import("fips_endpoints.zig").FipsEndpoints;
const StandbyReplicas = @import("standby_replicas.zig").StandbyReplicas;
const CollectionStatus = @import("collection_status.zig").CollectionStatus;
const CollectionType = @import("collection_type.zig").CollectionType;
const VectorOptions = @import("vector_options.zig").VectorOptions;

/// Details about each OpenSearch Serverless collection, including the
/// collection endpoint, the OpenSearch Dashboards endpoint, and FIPS-compliant
/// endpoints for federal government workloads.
pub const CollectionDetail = struct {
    /// The Amazon Resource Name (ARN) of the collection.
    arn: ?[]const u8,

    /// Collection-specific endpoint used to submit index, search, and data upload
    /// requests to an OpenSearch Serverless collection.
    collection_endpoint: ?[]const u8,

    /// The name of the collection group that contains this collection.
    collection_group_name: ?[]const u8,

    /// The Epoch time when the collection was created.
    created_date: ?i64,

    /// Collection-specific endpoint used to access OpenSearch Dashboards.
    dashboard_endpoint: ?[]const u8,

    /// A description of the collection.
    description: ?[]const u8,

    /// A failure code associated with the request.
    failure_code: ?[]const u8,

    /// A message associated with the failure code.
    failure_message: ?[]const u8,

    /// FIPS-compliant endpoints for the collection. These endpoints use FIPS 140-3
    /// validated cryptographic modules and are required for federal government
    /// workloads that must comply with FedRAMP security standards.
    fips_endpoints: ?FipsEndpoints,

    /// A unique identifier for the collection.
    id: ?[]const u8,

    /// The ARN of the Amazon Web Services KMS key used to encrypt the collection.
    kms_key_arn: ?[]const u8,

    /// The date and time when the collection was last modified.
    last_modified_date: ?i64,

    /// The name of the collection.
    name: ?[]const u8,

    /// Details about an OpenSearch Serverless collection.
    standby_replicas: ?StandbyReplicas,

    /// The current status of the collection.
    status: ?CollectionStatus,

    /// The type of collection.
    @"type": ?CollectionType,

    /// Configuration options for vector search capabilities in the collection.
    vector_options: ?VectorOptions,

    pub const json_field_names = .{
        .arn = "arn",
        .collection_endpoint = "collectionEndpoint",
        .collection_group_name = "collectionGroupName",
        .created_date = "createdDate",
        .dashboard_endpoint = "dashboardEndpoint",
        .description = "description",
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .fips_endpoints = "fipsEndpoints",
        .id = "id",
        .kms_key_arn = "kmsKeyArn",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .standby_replicas = "standbyReplicas",
        .status = "status",
        .@"type" = "type",
        .vector_options = "vectorOptions",
    };
};
