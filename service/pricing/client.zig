const aws = @import("aws");
const std = @import("std");

const describe_services = @import("describe_services.zig");
const get_attribute_values = @import("get_attribute_values.zig");
const get_price_list_file_url = @import("get_price_list_file_url.zig");
const get_products = @import("get_products.zig");
const list_price_lists = @import("list_price_lists.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pricing";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns the metadata for one service or a list of the metadata for all
    /// services. Use
    /// this without a service code to get the service codes for all services.
    /// Use it with a service code, such as `AmazonEC2`, to get information specific
    /// to
    /// that service, such as the attribute
    /// names available for that service. For example, some of the attribute names
    /// available for EC2 are
    /// `volumeType`, `maxIopsVolume`, `operation`,
    /// `locationType`, and `instanceCapacity10xlarge`.
    pub fn describeServices(self: *Self, allocator: std.mem.Allocator, input: describe_services.DescribeServicesInput, options: CallOptions) !describe_services.DescribeServicesOutput {
        return describe_services.execute(self, allocator, input, options);
    }

    /// Returns a list of attribute values. Attributes are similar to the details
    /// in a Price List API offer file. For a list of available attributes, see
    /// [Offer File
    /// Definitions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/reading-an-offer.html#pps-defs)
    /// in the [Billing and Cost Management User
    /// Guide](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-what-is.html).
    pub fn getAttributeValues(self: *Self, allocator: std.mem.Allocator, input: get_attribute_values.GetAttributeValuesInput, options: CallOptions) !get_attribute_values.GetAttributeValuesOutput {
        return get_attribute_values.execute(self, allocator, input, options);
    }

    /// *
    /// **This feature is in preview release and is subject to change. Your use of
    /// Amazon Web Services Price List API is subject to the Beta Service
    /// Participation terms of the [Amazon Web Services Service
    /// Terms](https://aws.amazon.com/service-terms/) (Section 1.10).**
    /// *
    ///
    /// This returns the URL that you can retrieve your Price List file from. This
    /// URL is based
    /// on the `PriceListArn` and `FileFormat` that you retrieve from the
    /// [ListPriceLists](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_ListPriceLists.html) response.
    pub fn getPriceListFileUrl(self: *Self, allocator: std.mem.Allocator, input: get_price_list_file_url.GetPriceListFileUrlInput, options: CallOptions) !get_price_list_file_url.GetPriceListFileUrlOutput {
        return get_price_list_file_url.execute(self, allocator, input, options);
    }

    /// Returns a list of all products that match the filter criteria.
    pub fn getProducts(self: *Self, allocator: std.mem.Allocator, input: get_products.GetProductsInput, options: CallOptions) !get_products.GetProductsOutput {
        return get_products.execute(self, allocator, input, options);
    }

    /// *
    /// **This feature is in preview release and is subject to change. Your use of
    /// Amazon Web Services Price List API is subject to the Beta Service
    /// Participation terms of the [Amazon Web Services Service
    /// Terms](https://aws.amazon.com/service-terms/) (Section 1.10).**
    /// *
    ///
    /// This returns a list of Price List references that the requester if
    /// authorized to view,
    /// given a `ServiceCode`, `CurrencyCode`, and an
    /// `EffectiveDate`. Use without a `RegionCode` filter to list Price
    /// List references from all available Amazon Web Services Regions. Use with a
    /// `RegionCode` filter to get the Price List reference that's specific to a
    /// specific Amazon Web Services Region. You can use the `PriceListArn` from the
    /// response to get your preferred Price List files through the
    /// [GetPriceListFileUrl](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_GetPriceListFileUrl.html) API.
    pub fn listPriceLists(self: *Self, allocator: std.mem.Allocator, input: list_price_lists.ListPriceListsInput, options: CallOptions) !list_price_lists.ListPriceListsOutput {
        return list_price_lists.execute(self, allocator, input, options);
    }

    pub fn describeServicesPaginator(self: *Self, params: describe_services.DescribeServicesInput) paginator.DescribeServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAttributeValuesPaginator(self: *Self, params: get_attribute_values.GetAttributeValuesInput) paginator.GetAttributeValuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getProductsPaginator(self: *Self, params: get_products.GetProductsInput) paginator.GetProductsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPriceListsPaginator(self: *Self, params: list_price_lists.ListPriceListsInput) paginator.ListPriceListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
