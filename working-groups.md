# Working Group Outputs

The SciCodes working groups develop shared practices, tools, and guidance that strengthen the interoperability, sustainability, and continuity of research software registries and repositories. Their work combines practical collaboration among member resources with reusable outputs for the broader research software infrastructure community.

## Metadata Engineering and Interoperability Working Group

The Metadata Engineering and Interoperability Working Group develops shared technical approaches for exchanging, validating, enriching, and discovering software metadata across SciCodes member registries and repositories.

The group uses community standards such as CodeMeta and Citation File Format (CFF) as interoperability layers while addressing the practical differences among the metadata models, workflows, and technical architectures used by SciCodes members.

### Goals

- Improve interoperability among SciCodes member metadata models and services
- Develop and maintain mappings between member schemas and community standards, particularly CodeMeta and CFF
- Provide reusable tooling for metadata validation, transformation, extraction, and enrichment
- Enable federated discovery across independently operated registries and repositories
- Identify metadata gaps and workflow barriers that limit software discovery, citation, and reuse
- Document interoperable patterns that can be adopted beyond SciCodes

### Outputs and Deliverables

The working group develops interoperable software components and reference implementations that can be used independently or composed into member workflows.

Current outputs include:

- [codemeticulous](https://github.com/scicodes/codemeticulous): Python library and CLI for converting between software metadata standards through a canonical CodeMeta representation  
- [pydantic-codemeta](https://github.com/scicodes/pydantic-codemeta): typed Pydantic models for validating and programmatically working with CodeMeta  
- [somef-core](https://github.com/scicodes/somef-core): tooling for extracting structured software metadata from repository documentation and related sources  
- [cffconvert](https://github.com/scicodes/cffconvert): validation and conversion tooling for Citation File Format metadata  

Planned and continuing deliverables include:

- Maintained crosswalks between member metadata schemas, CodeMeta, CFF, and other relevant standards
- Reference metadata examples and test fixtures representing SciCodes member resources
- Validation and interoperability tests for metadata exchanged among member systems
- Demonstrations of federated search and discovery across multiple SciCodes resources
- Documentation of recommended metadata exchange patterns and implementation practices
- Identification of metadata requirements needed to support preservation, migration, and continuity planning

## Resilience and Continuity Working Group

The Resilience and Continuity Working Group develops practical approaches for maintaining access to research software information and essential registry and repository functions through organizational, technical, financial, or operational change.

Resilience includes more than sustaining an individual service indefinitely. The group considers how the functions, metadata, software, knowledge, and stewardship responsibilities of a resource can persist when funding changes, infrastructure fails, organizations reorganize, maintainers leave, services migrate, or a resource reaches end of life.

Building on the *Nine Best Practices for Research Software Registries and Repositories* and related work on open research infrastructure, the group translates sustainability principles into concrete continuity planning that SciCodes members can implement and test.

### Goals

- Identify the essential functions and assets that should survive disruption or organizational change
- Develop practical continuity and succession planning for research software registries and repositories
- Improve the portability and preservation of metadata and other critical information
- Document dependencies, operational knowledge, and stewardship responsibilities
- Develop governance and decision-making processes for transitions and end-of-life scenarios
- Share approaches to sustainable funding and institutional stewardship
- Use the SciCodes network to explore mutual support and distributed approaches to infrastructure resilience

### Outputs and Deliverables

The working group will develop a **SciCodes Resilience and Continuity Framework** that member resources can use to assess risks, document dependencies, and prepare for service transitions.

The framework should include:

- **Resilience self-assessment**: a lightweight rubric for evaluating governance, financial, technical, operational, and stewardship risks
- **Essential-functions inventory**: a method for identifying which services, datasets, metadata, identifiers, interfaces, and community functions require continuity
- **Dependency map**: a template for documenting critical technical services, external platforms, institutional dependencies, people, credentials, and organizational relationships
- **Continuity plan template**: a practical plan covering service disruption, loss of key personnel, funding interruption, infrastructure migration, and organizational change
- **Succession and stewardship plan**: guidance for transferring responsibility for software, metadata, domains, documentation, accounts, and governance
- **Preservation and export profile**: recommendations for producing portable, standards-based exports sufficient to preserve or reconstruct essential registry information
- **End-of-life and transition guidance**: decision points and recommended practices for sunsetting, archiving, redirecting, transferring, or federating a resource
- **Recovery and transition exercises**: lightweight scenarios or tabletop exercises that allow member resources to test whether continuity plans actually work
- **Case studies**: documented examples of infrastructure transitions, migrations, disruptions, and successful continuity strategies

### Cross-Working-Group Deliverables

Metadata interoperability and resilience are closely connected. A resource cannot be meaningfully portable or preservable if its information cannot be interpreted outside its original system.

The two working groups should therefore collaborate on:

- A **minimum portable metadata profile** for preserving and transferring SciCodes registry records
- Machine-readable exports based on open community standards such as CodeMeta and CFF
- Tests demonstrating that metadata can move between independently operated SciCodes resources
- Documentation of provenance, identifiers, relationships, and other information required to preserve meaning during migration
- A prototype **registry continuity exercise** in which metadata from one member resource is exported, validated, transferred, and made discoverable through another environment
- Recommendations for how federated SciCodes infrastructure can provide redundancy without requiring centralized ownership of member resources

Together, these activities move SciCodes toward a network in which participating resources remain independently governed while benefiting from shared standards, interoperable tooling, and collective continuity capacity.
