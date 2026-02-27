const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_applicable_individual_assessments = @import("describe_applicable_individual_assessments.zig");
const describe_certificates = @import("describe_certificates.zig");
const describe_connections = @import("describe_connections.zig");
const describe_data_migrations = @import("describe_data_migrations.zig");
const describe_data_providers = @import("describe_data_providers.zig");
const describe_endpoint_settings = @import("describe_endpoint_settings.zig");
const describe_endpoint_types = @import("describe_endpoint_types.zig");
const describe_endpoints = @import("describe_endpoints.zig");
const describe_engine_versions = @import("describe_engine_versions.zig");
const describe_event_subscriptions = @import("describe_event_subscriptions.zig");
const describe_events = @import("describe_events.zig");
const describe_extension_pack_associations = @import("describe_extension_pack_associations.zig");
const describe_fleet_advisor_collectors = @import("describe_fleet_advisor_collectors.zig");
const describe_fleet_advisor_databases = @import("describe_fleet_advisor_databases.zig");
const describe_fleet_advisor_lsa_analysis = @import("describe_fleet_advisor_lsa_analysis.zig");
const describe_fleet_advisor_schema_object_summary = @import("describe_fleet_advisor_schema_object_summary.zig");
const describe_fleet_advisor_schemas = @import("describe_fleet_advisor_schemas.zig");
const describe_instance_profiles = @import("describe_instance_profiles.zig");
const describe_metadata_model_assessments = @import("describe_metadata_model_assessments.zig");
const describe_metadata_model_children = @import("describe_metadata_model_children.zig");
const describe_metadata_model_conversions = @import("describe_metadata_model_conversions.zig");
const describe_metadata_model_creations = @import("describe_metadata_model_creations.zig");
const describe_metadata_model_exports_as_script = @import("describe_metadata_model_exports_as_script.zig");
const describe_metadata_model_exports_to_target = @import("describe_metadata_model_exports_to_target.zig");
const describe_metadata_model_imports = @import("describe_metadata_model_imports.zig");
const describe_migration_projects = @import("describe_migration_projects.zig");
const describe_orderable_replication_instances = @import("describe_orderable_replication_instances.zig");
const describe_pending_maintenance_actions = @import("describe_pending_maintenance_actions.zig");
const describe_recommendation_limitations = @import("describe_recommendation_limitations.zig");
const describe_recommendations = @import("describe_recommendations.zig");
const describe_replication_configs = @import("describe_replication_configs.zig");
const describe_replication_instance_task_logs = @import("describe_replication_instance_task_logs.zig");
const describe_replication_instances = @import("describe_replication_instances.zig");
const describe_replication_subnet_groups = @import("describe_replication_subnet_groups.zig");
const describe_replication_table_statistics = @import("describe_replication_table_statistics.zig");
const describe_replication_task_assessment_results = @import("describe_replication_task_assessment_results.zig");
const describe_replication_task_assessment_runs = @import("describe_replication_task_assessment_runs.zig");
const describe_replication_task_individual_assessments = @import("describe_replication_task_individual_assessments.zig");
const describe_replication_tasks = @import("describe_replication_tasks.zig");
const describe_replications = @import("describe_replications.zig");
const describe_schemas = @import("describe_schemas.zig");
const describe_table_statistics = @import("describe_table_statistics.zig");

pub const DescribeApplicableIndividualAssessmentsPaginator = struct {
    client: *Client,
    params: describe_applicable_individual_assessments.DescribeApplicableIndividualAssessmentsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_applicable_individual_assessments.Options) !describe_applicable_individual_assessments.DescribeApplicableIndividualAssessmentsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_applicable_individual_assessments.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeCertificatesPaginator = struct {
    client: *Client,
    params: describe_certificates.DescribeCertificatesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_certificates.Options) !describe_certificates.DescribeCertificatesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_certificates.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeConnectionsPaginator = struct {
    client: *Client,
    params: describe_connections.DescribeConnectionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_connections.Options) !describe_connections.DescribeConnectionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_connections.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeDataMigrationsPaginator = struct {
    client: *Client,
    params: describe_data_migrations.DescribeDataMigrationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_data_migrations.Options) !describe_data_migrations.DescribeDataMigrationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_data_migrations.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeDataProvidersPaginator = struct {
    client: *Client,
    params: describe_data_providers.DescribeDataProvidersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_data_providers.Options) !describe_data_providers.DescribeDataProvidersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_data_providers.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEndpointSettingsPaginator = struct {
    client: *Client,
    params: describe_endpoint_settings.DescribeEndpointSettingsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_endpoint_settings.Options) !describe_endpoint_settings.DescribeEndpointSettingsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_endpoint_settings.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEndpointTypesPaginator = struct {
    client: *Client,
    params: describe_endpoint_types.DescribeEndpointTypesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_endpoint_types.Options) !describe_endpoint_types.DescribeEndpointTypesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_endpoint_types.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEndpointsPaginator = struct {
    client: *Client,
    params: describe_endpoints.DescribeEndpointsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_endpoints.Options) !describe_endpoints.DescribeEndpointsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_endpoints.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEngineVersionsPaginator = struct {
    client: *Client,
    params: describe_engine_versions.DescribeEngineVersionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_engine_versions.Options) !describe_engine_versions.DescribeEngineVersionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_engine_versions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEventSubscriptionsPaginator = struct {
    client: *Client,
    params: describe_event_subscriptions.DescribeEventSubscriptionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_event_subscriptions.Options) !describe_event_subscriptions.DescribeEventSubscriptionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_event_subscriptions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEventsPaginator = struct {
    client: *Client,
    params: describe_events.DescribeEventsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_events.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeExtensionPackAssociationsPaginator = struct {
    client: *Client,
    params: describe_extension_pack_associations.DescribeExtensionPackAssociationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_extension_pack_associations.Options) !describe_extension_pack_associations.DescribeExtensionPackAssociationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_extension_pack_associations.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeFleetAdvisorCollectorsPaginator = struct {
    client: *Client,
    params: describe_fleet_advisor_collectors.DescribeFleetAdvisorCollectorsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_fleet_advisor_collectors.Options) !describe_fleet_advisor_collectors.DescribeFleetAdvisorCollectorsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_fleet_advisor_collectors.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeFleetAdvisorDatabasesPaginator = struct {
    client: *Client,
    params: describe_fleet_advisor_databases.DescribeFleetAdvisorDatabasesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_fleet_advisor_databases.Options) !describe_fleet_advisor_databases.DescribeFleetAdvisorDatabasesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_fleet_advisor_databases.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeFleetAdvisorLsaAnalysisPaginator = struct {
    client: *Client,
    params: describe_fleet_advisor_lsa_analysis.DescribeFleetAdvisorLsaAnalysisInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_fleet_advisor_lsa_analysis.Options) !describe_fleet_advisor_lsa_analysis.DescribeFleetAdvisorLsaAnalysisOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_fleet_advisor_lsa_analysis.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeFleetAdvisorSchemaObjectSummaryPaginator = struct {
    client: *Client,
    params: describe_fleet_advisor_schema_object_summary.DescribeFleetAdvisorSchemaObjectSummaryInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_fleet_advisor_schema_object_summary.Options) !describe_fleet_advisor_schema_object_summary.DescribeFleetAdvisorSchemaObjectSummaryOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_fleet_advisor_schema_object_summary.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeFleetAdvisorSchemasPaginator = struct {
    client: *Client,
    params: describe_fleet_advisor_schemas.DescribeFleetAdvisorSchemasInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_fleet_advisor_schemas.Options) !describe_fleet_advisor_schemas.DescribeFleetAdvisorSchemasOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_fleet_advisor_schemas.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeInstanceProfilesPaginator = struct {
    client: *Client,
    params: describe_instance_profiles.DescribeInstanceProfilesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_instance_profiles.Options) !describe_instance_profiles.DescribeInstanceProfilesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_instance_profiles.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMetadataModelAssessmentsPaginator = struct {
    client: *Client,
    params: describe_metadata_model_assessments.DescribeMetadataModelAssessmentsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_metadata_model_assessments.Options) !describe_metadata_model_assessments.DescribeMetadataModelAssessmentsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_metadata_model_assessments.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMetadataModelChildrenPaginator = struct {
    client: *Client,
    params: describe_metadata_model_children.DescribeMetadataModelChildrenInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_metadata_model_children.Options) !describe_metadata_model_children.DescribeMetadataModelChildrenOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_metadata_model_children.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMetadataModelConversionsPaginator = struct {
    client: *Client,
    params: describe_metadata_model_conversions.DescribeMetadataModelConversionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_metadata_model_conversions.Options) !describe_metadata_model_conversions.DescribeMetadataModelConversionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_metadata_model_conversions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMetadataModelCreationsPaginator = struct {
    client: *Client,
    params: describe_metadata_model_creations.DescribeMetadataModelCreationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_metadata_model_creations.Options) !describe_metadata_model_creations.DescribeMetadataModelCreationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_metadata_model_creations.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMetadataModelExportsAsScriptPaginator = struct {
    client: *Client,
    params: describe_metadata_model_exports_as_script.DescribeMetadataModelExportsAsScriptInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_metadata_model_exports_as_script.Options) !describe_metadata_model_exports_as_script.DescribeMetadataModelExportsAsScriptOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_metadata_model_exports_as_script.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMetadataModelExportsToTargetPaginator = struct {
    client: *Client,
    params: describe_metadata_model_exports_to_target.DescribeMetadataModelExportsToTargetInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_metadata_model_exports_to_target.Options) !describe_metadata_model_exports_to_target.DescribeMetadataModelExportsToTargetOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_metadata_model_exports_to_target.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMetadataModelImportsPaginator = struct {
    client: *Client,
    params: describe_metadata_model_imports.DescribeMetadataModelImportsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_metadata_model_imports.Options) !describe_metadata_model_imports.DescribeMetadataModelImportsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_metadata_model_imports.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeMigrationProjectsPaginator = struct {
    client: *Client,
    params: describe_migration_projects.DescribeMigrationProjectsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_migration_projects.Options) !describe_migration_projects.DescribeMigrationProjectsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_migration_projects.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeOrderableReplicationInstancesPaginator = struct {
    client: *Client,
    params: describe_orderable_replication_instances.DescribeOrderableReplicationInstancesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_orderable_replication_instances.Options) !describe_orderable_replication_instances.DescribeOrderableReplicationInstancesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_orderable_replication_instances.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribePendingMaintenanceActionsPaginator = struct {
    client: *Client,
    params: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_pending_maintenance_actions.Options) !describe_pending_maintenance_actions.DescribePendingMaintenanceActionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_pending_maintenance_actions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeRecommendationLimitationsPaginator = struct {
    client: *Client,
    params: describe_recommendation_limitations.DescribeRecommendationLimitationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_recommendation_limitations.Options) !describe_recommendation_limitations.DescribeRecommendationLimitationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_recommendation_limitations.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeRecommendationsPaginator = struct {
    client: *Client,
    params: describe_recommendations.DescribeRecommendationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_recommendations.Options) !describe_recommendations.DescribeRecommendationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_recommendations.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationConfigsPaginator = struct {
    client: *Client,
    params: describe_replication_configs.DescribeReplicationConfigsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_configs.Options) !describe_replication_configs.DescribeReplicationConfigsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_configs.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationInstanceTaskLogsPaginator = struct {
    client: *Client,
    params: describe_replication_instance_task_logs.DescribeReplicationInstanceTaskLogsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_instance_task_logs.Options) !describe_replication_instance_task_logs.DescribeReplicationInstanceTaskLogsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_instance_task_logs.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationInstancesPaginator = struct {
    client: *Client,
    params: describe_replication_instances.DescribeReplicationInstancesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_instances.Options) !describe_replication_instances.DescribeReplicationInstancesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_instances.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationSubnetGroupsPaginator = struct {
    client: *Client,
    params: describe_replication_subnet_groups.DescribeReplicationSubnetGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_subnet_groups.Options) !describe_replication_subnet_groups.DescribeReplicationSubnetGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_subnet_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationTableStatisticsPaginator = struct {
    client: *Client,
    params: describe_replication_table_statistics.DescribeReplicationTableStatisticsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_table_statistics.Options) !describe_replication_table_statistics.DescribeReplicationTableStatisticsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_table_statistics.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationTaskAssessmentResultsPaginator = struct {
    client: *Client,
    params: describe_replication_task_assessment_results.DescribeReplicationTaskAssessmentResultsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_task_assessment_results.Options) !describe_replication_task_assessment_results.DescribeReplicationTaskAssessmentResultsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_task_assessment_results.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationTaskAssessmentRunsPaginator = struct {
    client: *Client,
    params: describe_replication_task_assessment_runs.DescribeReplicationTaskAssessmentRunsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_task_assessment_runs.Options) !describe_replication_task_assessment_runs.DescribeReplicationTaskAssessmentRunsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_task_assessment_runs.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationTaskIndividualAssessmentsPaginator = struct {
    client: *Client,
    params: describe_replication_task_individual_assessments.DescribeReplicationTaskIndividualAssessmentsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_task_individual_assessments.Options) !describe_replication_task_individual_assessments.DescribeReplicationTaskIndividualAssessmentsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_task_individual_assessments.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationTasksPaginator = struct {
    client: *Client,
    params: describe_replication_tasks.DescribeReplicationTasksInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_tasks.Options) !describe_replication_tasks.DescribeReplicationTasksOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_tasks.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationsPaginator = struct {
    client: *Client,
    params: describe_replications.DescribeReplicationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replications.Options) !describe_replications.DescribeReplicationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replications.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeSchemasPaginator = struct {
    client: *Client,
    params: describe_schemas.DescribeSchemasInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_schemas.Options) !describe_schemas.DescribeSchemasOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_schemas.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeTableStatisticsPaginator = struct {
    client: *Client,
    params: describe_table_statistics.DescribeTableStatisticsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_table_statistics.Options) !describe_table_statistics.DescribeTableStatisticsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_table_statistics.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};
