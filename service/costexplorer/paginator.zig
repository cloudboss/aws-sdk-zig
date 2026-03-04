const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const get_anomalies = @import("get_anomalies.zig");
const get_anomaly_monitors = @import("get_anomaly_monitors.zig");
const get_anomaly_subscriptions = @import("get_anomaly_subscriptions.zig");
const get_cost_and_usage_comparisons = @import("get_cost_and_usage_comparisons.zig");
const get_cost_comparison_drivers = @import("get_cost_comparison_drivers.zig");
const get_reservation_purchase_recommendation = @import("get_reservation_purchase_recommendation.zig");
const get_rightsizing_recommendation = @import("get_rightsizing_recommendation.zig");
const get_savings_plans_coverage = @import("get_savings_plans_coverage.zig");
const get_savings_plans_utilization_details = @import("get_savings_plans_utilization_details.zig");
const list_commitment_purchase_analyses = @import("list_commitment_purchase_analyses.zig");
const list_cost_allocation_tag_backfill_history = @import("list_cost_allocation_tag_backfill_history.zig");
const list_cost_allocation_tags = @import("list_cost_allocation_tags.zig");
const list_cost_category_definitions = @import("list_cost_category_definitions.zig");
const list_cost_category_resource_associations = @import("list_cost_category_resource_associations.zig");
const list_savings_plans_purchase_recommendation_generation = @import("list_savings_plans_purchase_recommendation_generation.zig");

pub const GetAnomaliesPaginator = struct {
    client: *Client,
    params: get_anomalies.GetAnomaliesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_anomalies.GetAnomaliesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_anomalies.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetAnomalyMonitorsPaginator = struct {
    client: *Client,
    params: get_anomaly_monitors.GetAnomalyMonitorsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_anomaly_monitors.GetAnomalyMonitorsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_anomaly_monitors.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetAnomalySubscriptionsPaginator = struct {
    client: *Client,
    params: get_anomaly_subscriptions.GetAnomalySubscriptionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_anomaly_subscriptions.GetAnomalySubscriptionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_anomaly_subscriptions.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetCostAndUsageComparisonsPaginator = struct {
    client: *Client,
    params: get_cost_and_usage_comparisons.GetCostAndUsageComparisonsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_cost_and_usage_comparisons.GetCostAndUsageComparisonsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_cost_and_usage_comparisons.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetCostComparisonDriversPaginator = struct {
    client: *Client,
    params: get_cost_comparison_drivers.GetCostComparisonDriversInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_cost_comparison_drivers.GetCostComparisonDriversOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_cost_comparison_drivers.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetReservationPurchaseRecommendationPaginator = struct {
    client: *Client,
    params: get_reservation_purchase_recommendation.GetReservationPurchaseRecommendationInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_reservation_purchase_recommendation.GetReservationPurchaseRecommendationOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_reservation_purchase_recommendation.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetRightsizingRecommendationPaginator = struct {
    client: *Client,
    params: get_rightsizing_recommendation.GetRightsizingRecommendationInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_rightsizing_recommendation.GetRightsizingRecommendationOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_rightsizing_recommendation.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetSavingsPlansCoveragePaginator = struct {
    client: *Client,
    params: get_savings_plans_coverage.GetSavingsPlansCoverageInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_savings_plans_coverage.GetSavingsPlansCoverageOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try get_savings_plans_coverage.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetSavingsPlansUtilizationDetailsPaginator = struct {
    client: *Client,
    params: get_savings_plans_utilization_details.GetSavingsPlansUtilizationDetailsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_savings_plans_utilization_details.GetSavingsPlansUtilizationDetailsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try get_savings_plans_utilization_details.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListCommitmentPurchaseAnalysesPaginator = struct {
    client: *Client,
    params: list_commitment_purchase_analyses.ListCommitmentPurchaseAnalysesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_commitment_purchase_analyses.ListCommitmentPurchaseAnalysesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try list_commitment_purchase_analyses.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListCostAllocationTagBackfillHistoryPaginator = struct {
    client: *Client,
    params: list_cost_allocation_tag_backfill_history.ListCostAllocationTagBackfillHistoryInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_cost_allocation_tag_backfill_history.ListCostAllocationTagBackfillHistoryOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_cost_allocation_tag_backfill_history.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListCostAllocationTagsPaginator = struct {
    client: *Client,
    params: list_cost_allocation_tags.ListCostAllocationTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_cost_allocation_tags.ListCostAllocationTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_cost_allocation_tags.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListCostCategoryDefinitionsPaginator = struct {
    client: *Client,
    params: list_cost_category_definitions.ListCostCategoryDefinitionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_cost_category_definitions.ListCostCategoryDefinitionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_cost_category_definitions.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListCostCategoryResourceAssociationsPaginator = struct {
    client: *Client,
    params: list_cost_category_resource_associations.ListCostCategoryResourceAssociationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_cost_category_resource_associations.ListCostCategoryResourceAssociationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_cost_category_resource_associations.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const ListSavingsPlansPurchaseRecommendationGenerationPaginator = struct {
    client: *Client,
    params: list_savings_plans_purchase_recommendation_generation.ListSavingsPlansPurchaseRecommendationGenerationInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_savings_plans_purchase_recommendation_generation.ListSavingsPlansPurchaseRecommendationGenerationOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try list_savings_plans_purchase_recommendation_generation.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};
