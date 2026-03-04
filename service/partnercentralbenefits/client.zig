const aws = @import("aws");
const std = @import("std");

const amend_benefit_application = @import("amend_benefit_application.zig");
const associate_benefit_application_resource = @import("associate_benefit_application_resource.zig");
const cancel_benefit_application = @import("cancel_benefit_application.zig");
const create_benefit_application = @import("create_benefit_application.zig");
const disassociate_benefit_application_resource = @import("disassociate_benefit_application_resource.zig");
const get_benefit = @import("get_benefit.zig");
const get_benefit_allocation = @import("get_benefit_allocation.zig");
const get_benefit_application = @import("get_benefit_application.zig");
const list_benefit_allocations = @import("list_benefit_allocations.zig");
const list_benefit_applications = @import("list_benefit_applications.zig");
const list_benefits = @import("list_benefits.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const recall_benefit_application = @import("recall_benefit_application.zig");
const submit_benefit_application = @import("submit_benefit_application.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_benefit_application = @import("update_benefit_application.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "PartnerCentral Benefits";

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

    /// Modifies an existing benefit application by applying amendments to specific
    /// fields while maintaining revision control.
    pub fn amendBenefitApplication(self: *Self, allocator: std.mem.Allocator, input: amend_benefit_application.AmendBenefitApplicationInput, options: CallOptions) !amend_benefit_application.AmendBenefitApplicationOutput {
        return amend_benefit_application.execute(self, allocator, input, options);
    }

    /// Links an AWS resource to an existing benefit application for tracking and
    /// management purposes.
    pub fn associateBenefitApplicationResource(self: *Self, allocator: std.mem.Allocator, input: associate_benefit_application_resource.AssociateBenefitApplicationResourceInput, options: CallOptions) !associate_benefit_application_resource.AssociateBenefitApplicationResourceOutput {
        return associate_benefit_application_resource.execute(self, allocator, input, options);
    }

    /// Cancels a benefit application that is currently in progress, preventing
    /// further processing.
    pub fn cancelBenefitApplication(self: *Self, allocator: std.mem.Allocator, input: cancel_benefit_application.CancelBenefitApplicationInput, options: CallOptions) !cancel_benefit_application.CancelBenefitApplicationOutput {
        return cancel_benefit_application.execute(self, allocator, input, options);
    }

    /// Creates a new benefit application for a partner to request access to AWS
    /// benefits and programs.
    pub fn createBenefitApplication(self: *Self, allocator: std.mem.Allocator, input: create_benefit_application.CreateBenefitApplicationInput, options: CallOptions) !create_benefit_application.CreateBenefitApplicationOutput {
        return create_benefit_application.execute(self, allocator, input, options);
    }

    /// Removes the association between an AWS resource and a benefit application.
    pub fn disassociateBenefitApplicationResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_benefit_application_resource.DisassociateBenefitApplicationResourceInput, options: CallOptions) !disassociate_benefit_application_resource.DisassociateBenefitApplicationResourceOutput {
        return disassociate_benefit_application_resource.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific benefit available in the
    /// partner catalog.
    pub fn getBenefit(self: *Self, allocator: std.mem.Allocator, input: get_benefit.GetBenefitInput, options: CallOptions) !get_benefit.GetBenefitOutput {
        return get_benefit.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific benefit allocation that has
    /// been granted to a partner.
    pub fn getBenefitAllocation(self: *Self, allocator: std.mem.Allocator, input: get_benefit_allocation.GetBenefitAllocationInput, options: CallOptions) !get_benefit_allocation.GetBenefitAllocationOutput {
        return get_benefit_allocation.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific benefit application.
    pub fn getBenefitApplication(self: *Self, allocator: std.mem.Allocator, input: get_benefit_application.GetBenefitApplicationInput, options: CallOptions) !get_benefit_application.GetBenefitApplicationOutput {
        return get_benefit_application.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of benefit allocations based on specified filter
    /// criteria.
    pub fn listBenefitAllocations(self: *Self, allocator: std.mem.Allocator, input: list_benefit_allocations.ListBenefitAllocationsInput, options: CallOptions) !list_benefit_allocations.ListBenefitAllocationsOutput {
        return list_benefit_allocations.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of benefit applications based on specified filter
    /// criteria.
    pub fn listBenefitApplications(self: *Self, allocator: std.mem.Allocator, input: list_benefit_applications.ListBenefitApplicationsInput, options: CallOptions) !list_benefit_applications.ListBenefitApplicationsOutput {
        return list_benefit_applications.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of available benefits based on specified filter
    /// criteria.
    pub fn listBenefits(self: *Self, allocator: std.mem.Allocator, input: list_benefits.ListBenefitsInput, options: CallOptions) !list_benefits.ListBenefitsOutput {
        return list_benefits.execute(self, allocator, input, options);
    }

    /// Retrieves all tags associated with a specific resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Recalls a submitted benefit application, returning it to draft status for
    /// further modifications.
    pub fn recallBenefitApplication(self: *Self, allocator: std.mem.Allocator, input: recall_benefit_application.RecallBenefitApplicationInput, options: CallOptions) !recall_benefit_application.RecallBenefitApplicationOutput {
        return recall_benefit_application.execute(self, allocator, input, options);
    }

    /// Submits a benefit application for review and processing by AWS.
    pub fn submitBenefitApplication(self: *Self, allocator: std.mem.Allocator, input: submit_benefit_application.SubmitBenefitApplicationInput, options: CallOptions) !submit_benefit_application.SubmitBenefitApplicationOutput {
        return submit_benefit_application.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing benefit application with new information while
    /// maintaining revision control.
    pub fn updateBenefitApplication(self: *Self, allocator: std.mem.Allocator, input: update_benefit_application.UpdateBenefitApplicationInput, options: CallOptions) !update_benefit_application.UpdateBenefitApplicationOutput {
        return update_benefit_application.execute(self, allocator, input, options);
    }

    pub fn listBenefitAllocationsPaginator(self: *Self, params: list_benefit_allocations.ListBenefitAllocationsInput) paginator.ListBenefitAllocationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBenefitApplicationsPaginator(self: *Self, params: list_benefit_applications.ListBenefitApplicationsInput) paginator.ListBenefitApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBenefitsPaginator(self: *Self, params: list_benefits.ListBenefitsInput) paginator.ListBenefitsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
