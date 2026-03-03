const IndexType = @import("index_type.zig").IndexType;

/// An index is the data store used by Amazon Web Services Resource Explorer to
/// hold information about your Amazon Web Services resources that the service
/// discovers.
pub const MemberIndex = struct {
    /// The account ID for the index.
    account_id: ?[]const u8 = null,

    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the index.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services Region in which the index exists.
    region: ?[]const u8 = null,

    /// The type of index. It can be one of the following values:
    ///
    /// * `LOCAL` – The index contains information about resources from only the
    ///   same Amazon Web Services Region.
    /// * `AGGREGATOR` – Resource Explorer replicates copies of the indexed
    ///   information about resources in all other Amazon Web Services Regions to
    ///   the aggregator index. This lets search results in the Region with the
    ///   aggregator index to include resources from all Regions in the account
    ///   where Resource Explorer is turned on.
    @"type": ?IndexType = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .arn = "Arn",
        .region = "Region",
        .@"type" = "Type",
    };
};
