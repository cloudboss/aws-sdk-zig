/// *
/// **This feature is in preview release and is subject to change. Your use of
/// Amazon Web Services Price List API is subject to the Beta Service
/// Participation terms of the [Amazon Web Services Service
/// Terms](https://aws.amazon.com/service-terms/) (Section 1.10).**
/// *
///
/// This is the type of price list references that match your request.
pub const PriceList = struct {
    /// The three alphabetical character ISO-4217 currency code the Price List files
    /// are
    /// denominated in.
    currency_code: ?[]const u8 = null,

    /// The format you want to retrieve your Price List files. The `FileFormat` can
    /// be obtained from the [
    /// `ListPriceList`
    /// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_ListPriceLists.html) response.
    file_formats: ?[]const []const u8 = null,

    /// The unique identifier that maps to where your Price List files are located.
    /// `PriceListArn` can be obtained from the [
    /// `ListPriceList`
    /// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_ListPriceLists.html) response.
    price_list_arn: ?[]const u8 = null,

    /// This is used to filter the Price List by Amazon Web Services Region. For
    /// example, to get
    /// the price list only for the `US East (N. Virginia)` Region, use
    /// `us-east-1`. If nothing is specified, you retrieve price lists for all
    /// applicable Regions. The available `RegionCode` list can be retrieved from [
    /// `GetAttributeValues`
    /// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_GetAttributeValues.html) API.
    region_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .file_formats = "FileFormats",
        .price_list_arn = "PriceListArn",
        .region_code = "RegionCode",
    };
};
