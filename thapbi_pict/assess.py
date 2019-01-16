"""Assess classification of ITS1 reads.

This implements the ``thapbi_pict assess ...`` command.
"""

import sys
import tempfile


def main(known, method, out_dir, debug=False):
    """Implement the thapbi_pict assess command."""
    assert isinstance(known, list)

    # Context manager should remove the temp dir:
    with tempfile.TemporaryDirectory() as shared_tmp:
        if debug:
            sys.stderr.write("DEBUG: Shared temp folder %s\n" % shared_tmp)

    sys.stderr.write("Assessed %s classifier" % method)

    sys.stdout.flush()
    sys.stderr.flush()
    return 0
