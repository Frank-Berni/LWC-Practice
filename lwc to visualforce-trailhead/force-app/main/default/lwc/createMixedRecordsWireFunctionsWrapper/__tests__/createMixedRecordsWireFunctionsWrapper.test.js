import { createElement } from 'lwc';
import CreateMixedRecordsWireFunctionsWrapper from 'c/createMixedRecordsWireFunctionsWrapper';

// Mock exampleWrapper component so that accessibility tests don't expect the visualforce iframe to load
jest.mock('../../exampleWrapper/exampleWrapper');

describe('c-create-mixed-records-wire-functions-wrapper', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });
    it('shows inner component using c-example-wrapper', () => {
        // Create initial element
        const element = createElement(
            'c-create-mixed-records-wire-functions-wrapper',
            {
                is: CreateMixedRecordsWireFunctionsWrapper
            }
        );
        document.body.appendChild(element);

        const exampleEl = element.shadowRoot.querySelector('c-example-wrapper');
        expect(exampleEl).not.toBeNull();

        const innerEl = exampleEl.querySelector(
            'c-create-mixed-records-wire-functions'
        );
        expect(innerEl).not.toBeNull();
    });

    it('is accessible', async () => {
        const element = createElement(
            'c-create-mixed-records-wire-functions-wrapper',
            {
                is: CreateMixedRecordsWireFunctionsWrapper
            }
        );

        document.body.appendChild(element);

        await expect(element).toBeAccessible();
    });
});
