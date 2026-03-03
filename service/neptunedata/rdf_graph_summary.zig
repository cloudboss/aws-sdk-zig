const aws = @import("aws");

const SubjectStructure = @import("subject_structure.zig").SubjectStructure;

/// The RDF graph summary API returns a read-only list of classes and predicate
/// keys, along with counts of quads, subjects, and predicates.
pub const RDFGraphSummary = struct {
    /// A list of the classes in the graph.
    classes: ?[]const []const u8 = null,

    /// The number of classes in the graph.
    num_classes: ?i64 = null,

    /// The number of distinct predicates in the graph.
    num_distinct_predicates: ?i64 = null,

    /// The number of distinct subjects in the graph.
    num_distinct_subjects: ?i64 = null,

    /// The number of quads in the graph.
    num_quads: ?i64 = null,

    /// "A list of predicates in the graph, along with the predicate counts.
    predicates: ?[]const []const aws.map.MapEntry(i64) = null,

    /// This field is only present when the request mode is `DETAILED`. It contains
    /// a list of subject structures.
    subject_structures: ?[]const SubjectStructure = null,

    pub const json_field_names = .{
        .classes = "classes",
        .num_classes = "numClasses",
        .num_distinct_predicates = "numDistinctPredicates",
        .num_distinct_subjects = "numDistinctSubjects",
        .num_quads = "numQuads",
        .predicates = "predicates",
        .subject_structures = "subjectStructures",
    };
};
