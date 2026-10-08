const aws = @import("aws");
const std = @import("std");

const get_listing = @import("get_listing.zig");
const get_offer = @import("get_offer.zig");
const get_offer_set = @import("get_offer_set.zig");
const get_offer_terms = @import("get_offer_terms.zig");
const get_product = @import("get_product.zig");
const list_fulfillment_options = @import("list_fulfillment_options.zig");
const list_purchase_options = @import("list_purchase_options.zig");
const search_facets = @import("search_facets.zig");
const search_listings = @import("search_listings.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Marketplace Discovery";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Provides details about a listing, such as descriptions, badges, categories,
    /// pricing model summaries, reviews, and associated products and offers.
    pub fn getListing(self: *Self, allocator: std.mem.Allocator, input: get_listing.GetListingInput, options: CallOptions) !get_listing.GetListingOutput {
        return get_listing.execute(self, allocator, input, options);
    }

    /// Provides details about an offer, such as the pricing model, seller of
    /// record, availability dates, badges, and associated products.
    pub fn getOffer(self: *Self, allocator: std.mem.Allocator, input: get_offer.GetOfferInput, options: CallOptions) !get_offer.GetOfferOutput {
        return get_offer.execute(self, allocator, input, options);
    }

    /// Provides details about an offer set, which is a bundle of offers across
    /// multiple products. Includes the seller, availability dates, buyer notes, and
    /// associated product-offer pairs.
    pub fn getOfferSet(self: *Self, allocator: std.mem.Allocator, input: get_offer_set.GetOfferSetInput, options: CallOptions) !get_offer_set.GetOfferSetOutput {
        return get_offer_set.execute(self, allocator, input, options);
    }

    /// Returns the terms attached to an offer, such as pricing terms (usage-based,
    /// contract, BYOL, free trial), legal terms, payment schedules, validity terms,
    /// support terms, and renewal terms.
    pub fn getOfferTerms(self: *Self, allocator: std.mem.Allocator, input: get_offer_terms.GetOfferTermsInput, options: CallOptions) !get_offer_terms.GetOfferTermsOutput {
        return get_offer_terms.execute(self, allocator, input, options);
    }

    /// Provides details about a product, such as descriptions, highlights,
    /// categories, fulfillment option summaries, promotional media, and seller
    /// engagement options.
    pub fn getProduct(self: *Self, allocator: std.mem.Allocator, input: get_product.GetProductInput, options: CallOptions) !get_product.GetProductOutput {
        return get_product.execute(self, allocator, input, options);
    }

    /// Returns the fulfillment options available for a product, including
    /// deployment details such as version information, operating systems, usage
    /// instructions, and release notes.
    pub fn listFulfillmentOptions(self: *Self, allocator: std.mem.Allocator, input: list_fulfillment_options.ListFulfillmentOptionsInput, options: CallOptions) !list_fulfillment_options.ListFulfillmentOptionsOutput {
        return list_fulfillment_options.execute(self, allocator, input, options);
    }

    /// Returns the purchase options (offers and offer sets) available to the buyer.
    /// You can filter results by product, seller, purchase option type, visibility
    /// scope, and availability status.
    ///
    /// You must include at least one of the following filters in the request: a
    /// `PRODUCT_ID` filter to specify the product for which to retrieve purchase
    /// options, or a `VISIBILITY_SCOPE` filter to retrieve purchase options by
    /// visibility.
    pub fn listPurchaseOptions(self: *Self, allocator: std.mem.Allocator, input: list_purchase_options.ListPurchaseOptionsInput, options: CallOptions) !list_purchase_options.ListPurchaseOptionsOutput {
        return list_purchase_options.execute(self, allocator, input, options);
    }

    /// Returns available facet values for filtering listings, such as categories,
    /// pricing models, fulfillment option types, publishers, and customer ratings.
    /// Each facet value includes a count of matching listings.
    pub fn searchFacets(self: *Self, allocator: std.mem.Allocator, input: search_facets.SearchFacetsInput, options: CallOptions) !search_facets.SearchFacetsOutput {
        return search_facets.execute(self, allocator, input, options);
    }

    /// Returns a list of product listings based on search criteria and filters. You
    /// can search by keyword, filter by category, pricing model, fulfillment type,
    /// and other attributes, and sort results by relevance or customer rating.
    pub fn searchListings(self: *Self, allocator: std.mem.Allocator, input: search_listings.SearchListingsInput, options: CallOptions) !search_listings.SearchListingsOutput {
        return search_listings.execute(self, allocator, input, options);
    }

    pub fn getOfferTermsPaginator(self: *Self, params: get_offer_terms.GetOfferTermsInput) paginator.GetOfferTermsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFulfillmentOptionsPaginator(self: *Self, params: list_fulfillment_options.ListFulfillmentOptionsInput) paginator.ListFulfillmentOptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPurchaseOptionsPaginator(self: *Self, params: list_purchase_options.ListPurchaseOptionsInput) paginator.ListPurchaseOptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchFacetsPaginator(self: *Self, params: search_facets.SearchFacetsInput) paginator.SearchFacetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchListingsPaginator(self: *Self, params: search_listings.SearchListingsInput) paginator.SearchListingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
