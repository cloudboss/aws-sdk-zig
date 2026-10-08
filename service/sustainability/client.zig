const aws = @import("aws");
const std = @import("std");

const get_estimated_carbon_emissions = @import("get_estimated_carbon_emissions.zig");
const get_estimated_carbon_emissions_dimension_values = @import("get_estimated_carbon_emissions_dimension_values.zig");
const get_estimated_water_allocation = @import("get_estimated_water_allocation.zig");
const get_estimated_water_allocation_dimension_values = @import("get_estimated_water_allocation_dimension_values.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Sustainability";

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

    /// Returns estimated carbon emission values based on customer grouping and
    /// filtering parameters. We recommend using pagination to ensure that the
    /// operation returns quickly and successfully.
    pub fn getEstimatedCarbonEmissions(self: *Self, allocator: std.mem.Allocator, input: get_estimated_carbon_emissions.GetEstimatedCarbonEmissionsInput, options: CallOptions) !get_estimated_carbon_emissions.GetEstimatedCarbonEmissionsOutput {
        return get_estimated_carbon_emissions.execute(self, allocator, input, options);
    }

    /// Returns the possible dimension values available for a customer's account. We
    /// recommend using pagination to ensure that the operation returns quickly and
    /// successfully.
    pub fn getEstimatedCarbonEmissionsDimensionValues(self: *Self, allocator: std.mem.Allocator, input: get_estimated_carbon_emissions_dimension_values.GetEstimatedCarbonEmissionsDimensionValuesInput, options: CallOptions) !get_estimated_carbon_emissions_dimension_values.GetEstimatedCarbonEmissionsDimensionValuesOutput {
        return get_estimated_carbon_emissions_dimension_values.execute(self, allocator, input, options);
    }

    /// Returns estimated water allocation values based on customer grouping and
    /// filtering parameters. We recommend using pagination to ensure that the
    /// operation returns quickly and successfully.
    pub fn getEstimatedWaterAllocation(self: *Self, allocator: std.mem.Allocator, input: get_estimated_water_allocation.GetEstimatedWaterAllocationInput, options: CallOptions) !get_estimated_water_allocation.GetEstimatedWaterAllocationOutput {
        return get_estimated_water_allocation.execute(self, allocator, input, options);
    }

    /// Returns the possible dimension values available for a customer's account. We
    /// recommend using pagination to ensure that the operation returns quickly and
    /// successfully.
    pub fn getEstimatedWaterAllocationDimensionValues(self: *Self, allocator: std.mem.Allocator, input: get_estimated_water_allocation_dimension_values.GetEstimatedWaterAllocationDimensionValuesInput, options: CallOptions) !get_estimated_water_allocation_dimension_values.GetEstimatedWaterAllocationDimensionValuesOutput {
        return get_estimated_water_allocation_dimension_values.execute(self, allocator, input, options);
    }

    pub fn getEstimatedCarbonEmissionsPaginator(self: *Self, params: get_estimated_carbon_emissions.GetEstimatedCarbonEmissionsInput) paginator.GetEstimatedCarbonEmissionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getEstimatedCarbonEmissionsDimensionValuesPaginator(self: *Self, params: get_estimated_carbon_emissions_dimension_values.GetEstimatedCarbonEmissionsDimensionValuesInput) paginator.GetEstimatedCarbonEmissionsDimensionValuesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getEstimatedWaterAllocationPaginator(self: *Self, params: get_estimated_water_allocation.GetEstimatedWaterAllocationInput) paginator.GetEstimatedWaterAllocationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getEstimatedWaterAllocationDimensionValuesPaginator(self: *Self, params: get_estimated_water_allocation_dimension_values.GetEstimatedWaterAllocationDimensionValuesInput) paginator.GetEstimatedWaterAllocationDimensionValuesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
