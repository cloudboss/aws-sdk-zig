const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const describe_portfolio_shares = @import("describe_portfolio_shares.zig");
const get_provisioned_product_outputs = @import("get_provisioned_product_outputs.zig");
const list_accepted_portfolio_shares = @import("list_accepted_portfolio_shares.zig");
const list_budgets_for_resource = @import("list_budgets_for_resource.zig");
const list_constraints_for_portfolio = @import("list_constraints_for_portfolio.zig");
const list_launch_paths = @import("list_launch_paths.zig");
const list_organization_portfolio_access = @import("list_organization_portfolio_access.zig");
const list_portfolio_access = @import("list_portfolio_access.zig");
const list_portfolios = @import("list_portfolios.zig");
const list_portfolios_for_product = @import("list_portfolios_for_product.zig");
const list_principals_for_portfolio = @import("list_principals_for_portfolio.zig");
const list_provisioning_artifacts_for_service_action = @import("list_provisioning_artifacts_for_service_action.zig");
const list_resources_for_tag_option = @import("list_resources_for_tag_option.zig");
const list_service_actions = @import("list_service_actions.zig");
const list_service_actions_for_provisioning_artifact = @import("list_service_actions_for_provisioning_artifact.zig");
const list_tag_options = @import("list_tag_options.zig");
const search_products = @import("search_products.zig");
const search_products_as_admin = @import("search_products_as_admin.zig");
const search_provisioned_products = @import("search_provisioned_products.zig");

pub const DescribePortfolioSharesPaginator = struct {
    client: *Client,
    params: describe_portfolio_shares.DescribePortfolioSharesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_portfolio_shares.DescribePortfolioSharesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try describe_portfolio_shares.execute(self.client, allocator, self.params, options);

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

pub const GetProvisionedProductOutputsPaginator = struct {
    client: *Client,
    params: get_provisioned_product_outputs.GetProvisionedProductOutputsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_provisioned_product_outputs.GetProvisionedProductOutputsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try get_provisioned_product_outputs.execute(self.client, allocator, self.params, options);

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

pub const ListAcceptedPortfolioSharesPaginator = struct {
    client: *Client,
    params: list_accepted_portfolio_shares.ListAcceptedPortfolioSharesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_accepted_portfolio_shares.ListAcceptedPortfolioSharesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_accepted_portfolio_shares.execute(self.client, allocator, self.params, options);

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

pub const ListBudgetsForResourcePaginator = struct {
    client: *Client,
    params: list_budgets_for_resource.ListBudgetsForResourceInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_budgets_for_resource.ListBudgetsForResourceOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_budgets_for_resource.execute(self.client, allocator, self.params, options);

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

pub const ListConstraintsForPortfolioPaginator = struct {
    client: *Client,
    params: list_constraints_for_portfolio.ListConstraintsForPortfolioInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_constraints_for_portfolio.ListConstraintsForPortfolioOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_constraints_for_portfolio.execute(self.client, allocator, self.params, options);

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

pub const ListLaunchPathsPaginator = struct {
    client: *Client,
    params: list_launch_paths.ListLaunchPathsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_launch_paths.ListLaunchPathsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_launch_paths.execute(self.client, allocator, self.params, options);

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

pub const ListOrganizationPortfolioAccessPaginator = struct {
    client: *Client,
    params: list_organization_portfolio_access.ListOrganizationPortfolioAccessInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_organization_portfolio_access.ListOrganizationPortfolioAccessOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_organization_portfolio_access.execute(self.client, allocator, self.params, options);

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

pub const ListPortfolioAccessPaginator = struct {
    client: *Client,
    params: list_portfolio_access.ListPortfolioAccessInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_portfolio_access.ListPortfolioAccessOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_portfolio_access.execute(self.client, allocator, self.params, options);

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

pub const ListPortfoliosPaginator = struct {
    client: *Client,
    params: list_portfolios.ListPortfoliosInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_portfolios.ListPortfoliosOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_portfolios.execute(self.client, allocator, self.params, options);

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

pub const ListPortfoliosForProductPaginator = struct {
    client: *Client,
    params: list_portfolios_for_product.ListPortfoliosForProductInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_portfolios_for_product.ListPortfoliosForProductOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_portfolios_for_product.execute(self.client, allocator, self.params, options);

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

pub const ListPrincipalsForPortfolioPaginator = struct {
    client: *Client,
    params: list_principals_for_portfolio.ListPrincipalsForPortfolioInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_principals_for_portfolio.ListPrincipalsForPortfolioOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_principals_for_portfolio.execute(self.client, allocator, self.params, options);

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

pub const ListProvisioningArtifactsForServiceActionPaginator = struct {
    client: *Client,
    params: list_provisioning_artifacts_for_service_action.ListProvisioningArtifactsForServiceActionInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_provisioning_artifacts_for_service_action.ListProvisioningArtifactsForServiceActionOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_provisioning_artifacts_for_service_action.execute(self.client, allocator, self.params, options);

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

pub const ListResourcesForTagOptionPaginator = struct {
    client: *Client,
    params: list_resources_for_tag_option.ListResourcesForTagOptionInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_resources_for_tag_option.ListResourcesForTagOptionOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_resources_for_tag_option.execute(self.client, allocator, self.params, options);

        if (output.page_token) |token| {
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

pub const ListServiceActionsPaginator = struct {
    client: *Client,
    params: list_service_actions.ListServiceActionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_service_actions.ListServiceActionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_service_actions.execute(self.client, allocator, self.params, options);

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

pub const ListServiceActionsForProvisioningArtifactPaginator = struct {
    client: *Client,
    params: list_service_actions_for_provisioning_artifact.ListServiceActionsForProvisioningArtifactInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_service_actions_for_provisioning_artifact.ListServiceActionsForProvisioningArtifactOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_service_actions_for_provisioning_artifact.execute(self.client, allocator, self.params, options);

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

pub const ListTagOptionsPaginator = struct {
    client: *Client,
    params: list_tag_options.ListTagOptionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_tag_options.ListTagOptionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try list_tag_options.execute(self.client, allocator, self.params, options);

        if (output.page_token) |token| {
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

pub const SearchProductsPaginator = struct {
    client: *Client,
    params: search_products.SearchProductsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !search_products.SearchProductsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try search_products.execute(self.client, allocator, self.params, options);

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

pub const SearchProductsAsAdminPaginator = struct {
    client: *Client,
    params: search_products_as_admin.SearchProductsAsAdminInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !search_products_as_admin.SearchProductsAsAdminOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try search_products_as_admin.execute(self.client, allocator, self.params, options);

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

pub const SearchProvisionedProductsPaginator = struct {
    client: *Client,
    params: search_provisioned_products.SearchProvisionedProductsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !search_provisioned_products.SearchProvisionedProductsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.page_token = self.next_token;

        const output = try search_provisioned_products.execute(self.client, allocator, self.params, options);

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
