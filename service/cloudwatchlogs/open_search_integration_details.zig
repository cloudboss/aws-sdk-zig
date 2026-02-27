const OpenSearchDataAccessPolicy = @import("open_search_data_access_policy.zig").OpenSearchDataAccessPolicy;
const OpenSearchApplication = @import("open_search_application.zig").OpenSearchApplication;
const OpenSearchCollection = @import("open_search_collection.zig").OpenSearchCollection;
const OpenSearchDataSource = @import("open_search_data_source.zig").OpenSearchDataSource;
const OpenSearchEncryptionPolicy = @import("open_search_encryption_policy.zig").OpenSearchEncryptionPolicy;
const OpenSearchLifecyclePolicy = @import("open_search_lifecycle_policy.zig").OpenSearchLifecyclePolicy;
const OpenSearchNetworkPolicy = @import("open_search_network_policy.zig").OpenSearchNetworkPolicy;
const OpenSearchWorkspace = @import("open_search_workspace.zig").OpenSearchWorkspace;

/// This structure contains complete information about one CloudWatch Logs
/// integration.
/// This structure is returned by a
/// [GetIntegration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetIntegration.html) operation.
pub const OpenSearchIntegrationDetails = struct {
    /// This structure contains information about the OpenSearch Service data access
    /// policy used
    /// for this integration. The access policy defines the access controls for the
    /// collection. This
    /// data access policy was automatically created as part of the integration
    /// setup. For more
    /// information about OpenSearch Service data access policies, see [Data access
    /// control for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-data-access.html) in the OpenSearch Service Developer
    /// Guide.
    access_policy: ?OpenSearchDataAccessPolicy,

    /// This structure contains information about the OpenSearch Service application
    /// used for this
    /// integration. An OpenSearch Service application is the web application that
    /// was created by the
    /// integration with CloudWatch Logs. It hosts the vended logs dashboards.
    application: ?OpenSearchApplication,

    /// This structure contains information about the OpenSearch Service collection
    /// used for this
    /// integration. This collection was created as part of the integration setup.
    /// An OpenSearch Service collection is a logical grouping of one or more
    /// indexes that represent an analytics
    /// workload. For more information, see [Creating and
    /// managing OpenSearch Service Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-collections.html).
    collection: ?OpenSearchCollection,

    /// This structure contains information about the OpenSearch Service data source
    /// used for this
    /// integration. This data source was created as part of the integration setup.
    /// An OpenSearch Service data source defines the source and destination for
    /// OpenSearch Service queries. It
    /// includes the role required to execute queries and write to collections.
    ///
    /// For more information about OpenSearch Service data sources , see [Creating
    /// OpenSearch Service data source integrations with Amazon
    /// S3.](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/direct-query-s3-creating.html)
    data_source: ?OpenSearchDataSource,

    /// This structure contains information about the OpenSearch Service encryption
    /// policy used
    /// for this integration. The encryption policy was created automatically when
    /// you created the
    /// integration. For more information, see [Encryption
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-encryption.html#serverless-encryption-policies) in the OpenSearch Service Developer Guide.
    encryption_policy: ?OpenSearchEncryptionPolicy,

    /// This structure contains information about the OpenSearch Service data
    /// lifecycle policy
    /// used for this integration. The lifecycle policy determines the lifespan of
    /// the data in the
    /// collection. It was automatically created as part of the integration setup.
    ///
    /// For more information, see [Using data
    /// lifecycle policies with OpenSearch Service
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html) in the OpenSearch Service
    /// Developer Guide.
    lifecycle_policy: ?OpenSearchLifecyclePolicy,

    /// This structure contains information about the OpenSearch Service network
    /// policy used for
    /// this integration. The network policy assigns network access settings to
    /// collections. For more
    /// information, see [Network
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-network.html#serverless-network-policies) in the OpenSearch Service Developer Guide.
    network_policy: ?OpenSearchNetworkPolicy,

    /// This structure contains information about the OpenSearch Service workspace
    /// used for this
    /// integration. An OpenSearch Service workspace is the collection of dashboards
    /// along with other
    /// OpenSearch Service tools. This workspace was created automatically as part
    /// of the
    /// integration setup. For more information, see [Centralized OpenSearch user
    /// interface (Dashboards) with OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/application.html).
    workspace: ?OpenSearchWorkspace,

    pub const json_field_names = .{
        .access_policy = "accessPolicy",
        .application = "application",
        .collection = "collection",
        .data_source = "dataSource",
        .encryption_policy = "encryptionPolicy",
        .lifecycle_policy = "lifecyclePolicy",
        .network_policy = "networkPolicy",
        .workspace = "workspace",
    };
};
