function dtmf_signal = create_number(student_number)
    fs = 8000;         % Sampling frequency
    Ts = 1/fs;         % Sampling period
    duration = 0.5;  % Duration of x signal
    pause_duration = 0.1; % Duration of pause

    % DTMF frequencies for each digit
    freq_set = [
        697 1209;  % 1
        697 1336;  % 2
        697 1477;  % 3
        697 1633;  % A
        770 1209;  % 4
        770 1336;  % 5
        770 1477;  % 6
        770 1633;  % B
        852 1209;  % 7
        852 1336;  % 8
        852 1477;  % 9
        852 1633;  % C
        941 1209;  % *
        941 1336;  % 0
        941 1477;  % #
        941 1633   % D
    ];

    % Remove the first 3 digits from student number
    student_number = num2str(student_number);
    student_number = student_number(4:13); % Keep the correct digits even if more are given

    % Initialize the signal
    dtmf_signal = [];
    % Generate the DTMF signal for each digit
    for i = 1:10
        digit = student_number(i);
        disp(digit);
        if(digit == '0')
          f1 = freq_set(14, 1); % Get frequency 1
          f2 = freq_set(14, 2); % Get frequency 2
        end
        if(digit == '1')
          f1 = freq_set(1, 1); % Get frequency 1
          f2 = freq_set(1, 2); % Get frequency 2
        end
        if(digit == '2')
          f1 = freq_set(2, 1); % Get frequency 1
          f2 = freq_set(2, 2); % Get frequency 2
        end
        if(digit == '3')
          f1 = freq_set(3, 1); % Get frequency 1
          f2 = freq_set(3, 2); % Get frequency 2
        end
        if(digit == '4')
          f1 = freq_set(5, 1); % Get frequency 1
          f2 = freq_set(5, 2); % Get frequency 2
        end
        if(digit == '5')
          f1 = freq_set(6, 1); % Get frequency 1
          f2 = freq_set(6, 2); % Get frequency 2
        end
        if(digit == '6')
          f1 = freq_set(7, 1); % Get frequency 1
          f2 = freq_set(7, 2); % Get frequency 2
        end
        if(digit == '7')
          f1 = freq_set(9, 1); % Get frequency 1
          f2 = freq_set(9, 2); % Get frequency 2
        end
        if(digit == '8')
          f1 = freq_set(10, 1); % Get frequency 1
          f2 = freq_set(10, 2); % Get frequency 2
        end
        if(digit == '9')
          f1 = freq_set(11, 1); % Get frequency 1
          f2 = freq_set(11, 2); % Get frequency 2
        end

        disp(f1);
        disp(f2);

        % Generate the DTMF x signal
        t = 0:Ts:duration;
        x = cos(2*pi*f1*t) + cos(2*pi*f2*t);
        dtmf_signal = [dtmf_signal x zeros(1, round(fs * pause_duration))];
    end

    % Display the signal
    figure;
    subplot(2,1,1);
    plot(dtmf_signal);
    title('DTMF Signal');
    xlabel('Seconds');

    % Calculate and display the amplitude of the FFT DTMF signal
    N = length(dtmf_signal);
    fft_dtmf_signal = abs(fft(dtmf_signal));
    dtmf_amplitude = fft_dtmf_signal(1:N/2+1); % Vectors must be same size
    dtmf_frequency = fs*(0:(N/2))/N;

    subplot(2,1,2);
    plot(dtmf_frequency, dtmf_amplitude);
    title('FFT of DTMF Signal');
    xlabel('Frequency in Hz');
    ylabel('Amplitude');

end