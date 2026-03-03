const ServiceEndpoint = @import("service_endpoint.zig").ServiceEndpoint;
const Limits = @import("limits.zig").Limits;

/// The current status of the search domain.
pub const DomainStatus = struct {
    arn: ?[]const u8 = null,

    /// True if the search domain is created. It can take several minutes to
    /// initialize a domain when CreateDomain is called. Newly created search
    /// domains are returned from DescribeDomains with a false value for Created
    /// until domain creation is complete.
    created: ?bool = null,

    /// True if the search domain has been deleted. The system must clean up
    /// resources dedicated to the search domain when DeleteDomain is called. Newly
    /// deleted search domains are returned from DescribeDomains with a true value
    /// for IsDeleted for several minutes until resource cleanup is complete.
    deleted: ?bool = null,

    /// The service endpoint for updating documents in a search domain.
    doc_service: ?ServiceEndpoint = null,

    domain_id: []const u8,

    domain_name: []const u8,

    limits: ?Limits = null,

    /// True if processing is being done to activate the current domain
    /// configuration.
    processing: ?bool = null,

    /// True if IndexDocuments needs to be called to activate the current domain
    /// configuration.
    requires_index_documents: bool,

    /// The number of search instances that are available to process search
    /// requests.
    search_instance_count: ?i32 = null,

    /// The instance type that is being used to process search requests.
    search_instance_type: ?[]const u8 = null,

    /// The number of partitions across which the search index is spread.
    search_partition_count: ?i32 = null,

    /// The service endpoint for requesting search results from a search domain.
    search_service: ?ServiceEndpoint = null,
};
