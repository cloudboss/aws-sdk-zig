const DependencyCriticality = @import("dependency_criticality.zig").DependencyCriticality;
const TestRunDependencySource = @import("test_run_dependency_source.zig").TestRunDependencySource;

/// Contains summary information about a dependency that a test run blocked, as
/// captured when the run started.
pub const TestRunDependencySummary = struct {
    /// The criticality classification of the dependency when the run started. A
    /// dependency that was not discovered has the UNKNOWN criticality.
    criticality: DependencyCriticality,

    /// The unique identifier of the dependency. Absent when the dependency was
    /// entered manually and was not part of dependency discovery.
    dependency_id: ?[]const u8 = null,

    /// The name of the dependency.
    dependency_name: []const u8,

    /// The DNS name of the dependency that the test run blocked.
    dns_name: []const u8,

    /// The location of the dependency.
    location: ?[]const u8 = null,

    /// The provider of the dependency.
    provider: ?[]const u8 = null,

    /// The origin of the dependency. A discovered dependency was found by
    /// dependency discovery; a manual dependency was entered when the run started.
    source: TestRunDependencySource,

    /// The source Regions from which the dependency was detected.
    source_regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .criticality = "criticality",
        .dependency_id = "dependencyId",
        .dependency_name = "dependencyName",
        .dns_name = "dnsName",
        .location = "location",
        .provider = "provider",
        .source = "source",
        .source_regions = "sourceRegions",
    };
};
