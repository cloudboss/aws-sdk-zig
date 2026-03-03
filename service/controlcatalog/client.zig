const aws = @import("aws");
const std = @import("std");

const get_control = @import("get_control.zig");
const list_common_controls = @import("list_common_controls.zig");
const list_control_mappings = @import("list_control_mappings.zig");
const list_controls = @import("list_controls.zig");
const list_domains = @import("list_domains.zig");
const list_objectives = @import("list_objectives.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ControlCatalog";

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

    /// Returns details about a specific control, most notably a list of Amazon Web
    /// Services Regions where this control is supported. Input a value for the
    /// *ControlArn* parameter, in ARN form. `GetControl` accepts *controltower* or
    /// *controlcatalog* control ARNs as input. Returns a *controlcatalog* ARN
    /// format.
    ///
    /// In the API response, controls that have the value `GLOBAL` in the `Scope`
    /// field do not show the `DeployableRegions` field, because it does not apply.
    /// Controls that have the value `REGIONAL` in the `Scope` field return a value
    /// for the `DeployableRegions` field, as shown in the example.
    pub fn getControl(self: *Self, allocator: std.mem.Allocator, input: get_control.GetControlInput, options: get_control.Options) !get_control.GetControlOutput {
        return get_control.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of common controls from the Amazon Web Services
    /// Control Catalog.
    ///
    /// You can apply an optional filter to see common controls that have a specific
    /// objective. If you don’t provide a filter, the operation returns all common
    /// controls.
    pub fn listCommonControls(self: *Self, allocator: std.mem.Allocator, input: list_common_controls.ListCommonControlsInput, options: list_common_controls.Options) !list_common_controls.ListCommonControlsOutput {
        return list_common_controls.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of control mappings from the Control Catalog.
    /// Control mappings show relationships between controls and other entities,
    /// such as common controls or compliance frameworks.
    pub fn listControlMappings(self: *Self, allocator: std.mem.Allocator, input: list_control_mappings.ListControlMappingsInput, options: list_control_mappings.Options) !list_control_mappings.ListControlMappingsOutput {
        return list_control_mappings.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all available controls in the Control Catalog
    /// library. Allows you to discover available controls. The list of controls is
    /// given as structures of type *controlSummary*. The ARN is returned in the
    /// global *controlcatalog* format, as shown in the examples.
    pub fn listControls(self: *Self, allocator: std.mem.Allocator, input: list_controls.ListControlsInput, options: list_controls.Options) !list_controls.ListControlsOutput {
        return list_controls.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of domains from the Control Catalog.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: list_domains.Options) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of objectives from the Control Catalog.
    ///
    /// You can apply an optional filter to see the objectives that belong to a
    /// specific domain. If you don’t provide a filter, the operation returns all
    /// objectives.
    pub fn listObjectives(self: *Self, allocator: std.mem.Allocator, input: list_objectives.ListObjectivesInput, options: list_objectives.Options) !list_objectives.ListObjectivesOutput {
        return list_objectives.execute(self, allocator, input, options);
    }

    pub fn listCommonControlsPaginator(self: *Self, params: list_common_controls.ListCommonControlsInput) paginator.ListCommonControlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listControlMappingsPaginator(self: *Self, params: list_control_mappings.ListControlMappingsInput) paginator.ListControlMappingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listControlsPaginator(self: *Self, params: list_controls.ListControlsInput) paginator.ListControlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listObjectivesPaginator(self: *Self, params: list_objectives.ListObjectivesInput) paginator.ListObjectivesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
