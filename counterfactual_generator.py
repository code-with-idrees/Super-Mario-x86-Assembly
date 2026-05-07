"""
=============================================================================
COUNTERFACTUAL SAMPLE GENERATOR
=============================================================================
A comprehensive tool for generating counterfactual samples from hate speech
datasets by replacing identity terms with alternative identities.

This implementation extends the basic starter code with:
- Extended identity lexicon with multiple identity groups
- Case-sensitive replacement (preserves original capitalization)
- Plural/singular form handling
- Detailed statistics and analysis
- Multiple output formats (JSON, CSV)
- Validation and error handling
- Summary report generation

Author: Student Implementation
Date: 2026-01-25
=============================================================================
"""

import json
import random
import csv
from copy import deepcopy
from collections import defaultdict
from datetime import datetime
import os

# =============================================================================
# CONFIGURATION
# =============================================================================

# Dataset paths
DATASET_PATH = r"C:\Users\HP\Downloads\dataset.json"
OUTPUT_JSON_PATH = "counterfactual_dataset.json"
OUTPUT_CSV_PATH = "counterfactual_dataset.csv"
STATS_PATH = "counterfactual_stats.json"
REPORT_PATH = "counterfactual_report.txt"

# =============================================================================
# EXTENDED IDENTITY LEXICON
# =============================================================================
# This lexicon maps identity terms to their counterfactual alternatives.
# Each identity term can have multiple alternatives for diverse generation.

IDENTITY_MAP = {
    # Religious identities
    "muslim": ["christian", "jewish"],
    "muslims": ["christians", "jews"],
    "islamic": ["christian", "jewish"],
    "islam": ["christianity", "judaism"],
    
    # Sexual orientation
    "gay": ["straight"],
    "gays": ["straights"],
    "homosexual": ["heterosexual"],
    "homosexuals": ["heterosexuals"],
    "lesbian": ["straight"],
    "lesbians": ["straights"],
    
    # Racial/ethnic identities
    "black": ["white"],
    "blacks": ["whites"],
    "african": ["european"],
    "africans": ["europeans"],
    
    # Gender identities
    "women": ["men"],
    "woman": ["man"],
    "female": ["male"],
    "females": ["males"],
    "girl": ["boy"],
    "girls": ["boys"],
}



# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

def preserve_case(original: str, replacement: str) -> str:
    """
    Preserve the case pattern of the original word in the replacement.
    
    Examples:
        preserve_case("Muslim", "christian") -> "Christian"
        preserve_case("MUSLIM", "christian") -> "CHRISTIAN"
        preserve_case("muslim", "Christian") -> "christian"
    
    Args:
        original: The original word with its case pattern
        replacement: The replacement word to apply the case pattern to
    
    Returns:
        The replacement word with the original's case pattern
    """
    if original.isupper():
        return replacement.upper()
    elif original.islower():
        return replacement.lower()
    elif original.istitle():
        return replacement.capitalize()
    else:
        # Mixed case - just return replacement as-is
        return replacement


def find_identity_matches(tokens: list, identity_map: dict) -> list:
    """
    Find all identity terms in the token list.
    
    Args:
        tokens: List of tokens from the post
        identity_map: Dictionary mapping identity terms to alternatives
    
    Returns:
        List of tuples: (index, original_token, lowercase_token)
    """
    matches = []
    for i, token in enumerate(tokens):
        token_lower = token.lower()
        if token_lower in identity_map:
            matches.append((i, token, token_lower))
    return matches


def generate_single_counterfactual(tokens: list, index: int, 
                                    original_token: str, 
                                    replacement: str) -> str:
    """
    Generate a single counterfactual by replacing one token.
    
    Args:
        tokens: Original list of tokens
        index: Index of token to replace
        original_token: The original token (for case preservation)
        replacement: The replacement identity term
    
    Returns:
        The counterfactual text as a string
    """
    cf_tokens = deepcopy(tokens)
    # Preserve the original case pattern
    cf_tokens[index] = preserve_case(original_token, replacement)
    return " ".join(cf_tokens)


def generate_all_counterfactuals(tokens: list, matches: list, 
                                  identity_map: dict) -> list:
    """
    Generate all possible counterfactuals for a given post.
    
    For each identity match, creates counterfactuals with each possible
    alternative identity term.
    
    Args:
        tokens: Original list of tokens
        matches: List of identity matches from find_identity_matches
        identity_map: Dictionary mapping identity terms to alternatives
    
    Returns:
        List of dictionaries containing counterfactual information
    """
    counterfactuals = []
    original_text = " ".join(tokens)
    
    for index, original_token, token_lower in matches:
        alternatives = identity_map[token_lower]
        
        for replacement in alternatives:
            cf_text = generate_single_counterfactual(
                tokens, index, original_token, replacement
            )
            
            counterfactuals.append({
                "original_text": original_text,
                "counterfactual_text": cf_text,
                "replaced_identity": {
                    "original": original_token,
                    "counterfactual": preserve_case(original_token, replacement),
                    "position": index
                }
            })
    
    return counterfactuals


# =============================================================================
# STATISTICS TRACKING
# =============================================================================

class StatisticsTracker:
    """
    Tracks statistics about the counterfactual generation process.
    """
    
    def __init__(self):
        self.total_posts = 0
        self.posts_with_identity = 0
        self.total_counterfactuals = 0
        self.identity_counts = defaultdict(int)
        self.replacement_counts = defaultdict(lambda: defaultdict(int))
        self.posts_by_identity_count = defaultdict(int)
        
    def record_post(self, matches: list, counterfactuals: list):
        """Record statistics for a processed post."""
        self.total_posts += 1
        
        if matches:
            self.posts_with_identity += 1
            self.posts_by_identity_count[len(matches)] += 1
            
        for _, original_token, token_lower in matches:
            self.identity_counts[token_lower] += 1
            
        for cf in counterfactuals:
            self.total_counterfactuals += 1
            orig = cf["replaced_identity"]["original"].lower()
            repl = cf["replaced_identity"]["counterfactual"].lower()
            self.replacement_counts[orig][repl] += 1
    
    def get_summary(self) -> dict:
        """Get a summary of all statistics."""
        return {
            "total_posts_processed": self.total_posts,
            "posts_with_identity_terms": self.posts_with_identity,
            "posts_without_identity_terms": self.total_posts - self.posts_with_identity,
            "percentage_with_identity": round(
                (self.posts_with_identity / self.total_posts * 100) 
                if self.total_posts > 0 else 0, 2
            ),
            "total_counterfactuals_generated": self.total_counterfactuals,
            "identity_term_frequency": dict(self.identity_counts),
            "replacement_distribution": {
                k: dict(v) for k, v in self.replacement_counts.items()
            },
            "posts_by_identity_count": dict(self.posts_by_identity_count)
        }


# =============================================================================
# OUTPUT FUNCTIONS
# =============================================================================

def save_json(data: list, filepath: str):
    """Save counterfactual data to JSON file."""
    with open(filepath, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    print(f"[OK] JSON output saved to: {filepath}")


def save_csv(data: list, filepath: str):
    """Save counterfactual data to CSV file."""
    if not data:
        print("[WARNING] No data to save to CSV")
        return
        
    fieldnames = [
        "post_id", 
        "original_text", 
        "counterfactual_text",
        "original_identity",
        "counterfactual_identity",
        "position"
    ]
    
    with open(filepath, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        
        for item in data:
            writer.writerow({
                "post_id": item["post_id"],
                "original_text": item["original_text"],
                "counterfactual_text": item["counterfactual_text"],
                "original_identity": item["replaced_identity"]["original"],
                "counterfactual_identity": item["replaced_identity"]["counterfactual"],
                "position": item["replaced_identity"]["position"]
            })
    
    print(f"[OK] CSV output saved to: {filepath}")


def save_stats(stats: dict, filepath: str):
    """Save statistics to JSON file."""
    with open(filepath, "w", encoding="utf-8") as f:
        json.dump(stats, f, indent=2)
    print(f"[OK] Statistics saved to: {filepath}")


def generate_report(stats: dict, filepath: str):
    """Generate a human-readable report."""
    report_lines = [
        "=" * 70,
        "COUNTERFACTUAL GENERATION REPORT",
        f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
        "=" * 70,
        "",
        "OVERVIEW",
        "-" * 40,
        f"Total posts processed:           {stats['total_posts_processed']:,}",
        f"Posts with identity terms:       {stats['posts_with_identity_terms']:,}",
        f"Posts without identity terms:    {stats['posts_without_identity_terms']:,}",
        f"Percentage with identities:      {stats['percentage_with_identity']}%",
        f"Total counterfactuals generated: {stats['total_counterfactuals_generated']:,}",
        "",
        "IDENTITY TERM FREQUENCY",
        "-" * 40,
    ]
    
    # Sort identity terms by frequency
    sorted_identities = sorted(
        stats['identity_term_frequency'].items(),
        key=lambda x: x[1],
        reverse=True
    )
    
    for term, count in sorted_identities:
        report_lines.append(f"  {term:20s} : {count:,}")
    
    report_lines.extend([
        "",
        "REPLACEMENT DISTRIBUTION",
        "-" * 40,
    ])
    
    for original, replacements in stats['replacement_distribution'].items():
        for replacement, count in replacements.items():
            report_lines.append(f"  {original} -> {replacement}: {count:,}")
    
    report_lines.extend([
        "",
        "POSTS BY NUMBER OF IDENTITY TERMS",
        "-" * 40,
    ])
    
    for count, posts in sorted(stats['posts_by_identity_count'].items()):
        report_lines.append(f"  {count} identity term(s): {posts:,} posts")
    
    report_lines.extend([
        "",
        "=" * 70,
        "END OF REPORT",
        "=" * 70,
    ])
    
    report_text = "\n".join(report_lines)
    
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(report_text)
    
    print(f"[OK] Report saved to: {filepath}")
    print("\n" + report_text)


# =============================================================================
# MAIN PROCESSING FUNCTION
# =============================================================================

def process_dataset(dataset_path: str, 
                    identity_map: dict = IDENTITY_MAP) -> tuple:
    """
    Process the entire dataset and generate counterfactuals.
    
    Args:
        dataset_path: Path to the input JSON dataset
        identity_map: Dictionary mapping identity terms to alternatives
    
    Returns:
        Tuple of (counterfactual_data, statistics)
    """
    print("=" * 70)
    print("COUNTERFACTUAL SAMPLE GENERATOR")
    print("=" * 70)
    print(f"\nLoading dataset from: {dataset_path}")
    
    print(f"[OK] Identity lexicon loaded with {len(identity_map)} terms")
    
    # Load dataset
    with open(dataset_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    
    print(f"[OK] Dataset loaded with {len(data):,} posts")
    print("\nProcessing posts...")
    
    # Initialize tracking
    counterfactual_data = []
    stats = StatisticsTracker()
    
    # Process each post
    for post_id, sample in data.items():
        tokens = sample["post_tokens"]
        
        # Find identity matches
        matches = find_identity_matches(tokens, identity_map)
        
        # Generate counterfactuals
        counterfactuals = generate_all_counterfactuals(
            tokens, matches, identity_map
        )
        
        # Add post_id to each counterfactual
        for cf in counterfactuals:
            cf["post_id"] = post_id
            counterfactual_data.append(cf)
        
        # Record statistics
        stats.record_post(matches, counterfactuals)
    
    print(f"\n[OK] Processing complete!")
    
    return counterfactual_data, stats.get_summary()


# =============================================================================
# MAIN EXECUTION
# =============================================================================

def main():
    """Main execution function."""
    
    # Process the dataset
    counterfactual_data, stats = process_dataset(
        DATASET_PATH,
        identity_map=IDENTITY_MAP
    )
    
    print(f"\n{'=' * 70}")
    print("SAVING OUTPUTS")
    print("=" * 70)
    
    # Save outputs
    save_json(counterfactual_data, OUTPUT_JSON_PATH)
    save_csv(counterfactual_data, OUTPUT_CSV_PATH)
    save_stats(stats, STATS_PATH)
    generate_report(stats, REPORT_PATH)
    
    print(f"\n{'=' * 70}")
    print("GENERATION COMPLETE")
    print(f"{'=' * 70}")
    print(f"\nTotal counterfactual samples generated: {len(counterfactual_data):,}")
    print("\nOutput files:")
    print(f"  - {OUTPUT_JSON_PATH}")
    print(f"  - {OUTPUT_CSV_PATH}")
    print(f"  - {STATS_PATH}")
    print(f"  - {REPORT_PATH}")


if __name__ == "__main__":
    main()
