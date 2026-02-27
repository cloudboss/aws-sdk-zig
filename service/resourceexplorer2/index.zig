const IndexType = @import("index_type.zig").IndexType;

/// An index is the data store used by Amazon Web Services Resource Explorer to
/// hold information about your Amazon Web Services resources that the service
/// discovers. Creating an index in an Amazon Web Services Region turns on
/// Resource Explorer and lets it discover your resources.
///
/// By default, an index is *local*, meaning that it contains information about
/// resources in only the same Region as the index. However, you can promote the
/// index of one Region in the account by calling UpdateIndexType to convert it
/// into an aggregator index. The aggregator index receives a replicated copy of
/// the index information from all other Regions where Resource Explorer is
/// turned on. This allows search operations in that Region to return results
/// from all Regions in the account.
pub const Index = struct {
    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the index.
    arn: ?[]const u8,

    /// The Amazon Web Services Region in which the index exists.
    region: ?[]const u8,

    /// The type of index. It can be one of the following values:
    ///
    /// * `LOCAL` – The index contains information about resources from only the
    ///   same Amazon Web Services Region.
    /// * `AGGREGATOR` – Resource Explorer replicates copies of the indexed
    ///   information about resources in all other Amazon Web Services Regions to
    ///   the aggregator index. This lets search results in the Region with the
    ///   aggregator index to include resources from all Regions in the account
    ///   where Resource Explorer is turned on.
    type: ?IndexType,

    pub const json_field_names = .{
        .arn = "Arn",
        .region = "Region",
        .type = "Type",
    };
};
