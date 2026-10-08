const aws = @import("aws");
const std = @import("std");

const get_request_authorization_details = @import("get_request_authorization_details.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "IAM Toolbox";

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

    /// Retrieves the authorization details for a specific access denied request.
    /// The details include the request context, the evaluations performed, and the
    /// policies that were evaluated.
    ///
    /// Use this operation to understand why a request was denied. Supported
    /// services include an authorization ID in the access denied error message.
    /// Pass that ID to this operation to retrieve the details.
    ///
    /// Authorization details are available for at least 24 hours after the denial.
    ///
    /// To use this operation, you must have the
    /// `iam:GetRequestAuthorizationDetails` permission.
    pub fn getRequestAuthorizationDetails(self: *Self, allocator: std.mem.Allocator, input: get_request_authorization_details.GetRequestAuthorizationDetailsInput, options: CallOptions) !get_request_authorization_details.GetRequestAuthorizationDetailsOutput {
        return get_request_authorization_details.execute(self, allocator, input, options);
    }

    pub fn getRequestAuthorizationDetailsPaginator(self: *Self, params: get_request_authorization_details.GetRequestAuthorizationDetailsInput) paginator.GetRequestAuthorizationDetailsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
