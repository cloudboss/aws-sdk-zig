const aws = @import("aws");
const std = @import("std");

const get_account_customizations = @import("get_account_customizations.zig");
const list_services = @import("list_services.zig");
const update_account_customizations = @import("update_account_customizations.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "uxc";

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

    /// Returns the current account customization settings, including account color,
    /// visible services, and visible Regions. Settings that you have not configured
    /// return their default values: visible Regions and visible services return
    /// `null`, and account color returns `none`.
    ///
    /// The `visibleServices` and `visibleRegions` settings control only the
    /// appearance of services and Regions in the Amazon Web Services Management
    /// Console. They do not restrict access through the CLI, SDKs, or other APIs.
    pub fn getAccountCustomizations(self: *Self, allocator: std.mem.Allocator, input: get_account_customizations.GetAccountCustomizationsInput, options: CallOptions) !get_account_customizations.GetAccountCustomizationsOutput {
        return get_account_customizations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of Amazon Web Services service identifiers that you
    /// can use as values for the `visibleServices` setting in
    /// [UpdateAccountCustomizations](https://docs.aws.amazon.com/awsconsolehelpdocs/latest/APIReference/API_UpdateAccountCustomizations.html). The available services vary by Amazon Web Services partition. Use pagination to retrieve all results.
    ///
    /// The `visibleServices` setting controls only the appearance of services in
    /// the Amazon Web Services Management Console. It does not restrict access
    /// through the CLI, SDKs, or other APIs.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: CallOptions) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Updates one or more account customization settings. You can update account
    /// color, visible services, and visible Regions in a single request. Only the
    /// settings that you include in the request body are modified. Omitted settings
    /// remain unchanged. To reset a setting to its default behavior, set the value
    /// to `null` for visible Regions and visible services, or `none` for account
    /// color. This operation is idempotent.
    ///
    /// The `visibleServices` and `visibleRegions` settings control only the
    /// appearance of services and Regions in the Amazon Web Services Management
    /// Console. They do not restrict access through the CLI, SDKs, or other APIs.
    pub fn updateAccountCustomizations(self: *Self, allocator: std.mem.Allocator, input: update_account_customizations.UpdateAccountCustomizationsInput, options: CallOptions) !update_account_customizations.UpdateAccountCustomizationsOutput {
        return update_account_customizations.execute(self, allocator, input, options);
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
